import 'dart:io';

import 'package:remotely/features/support/data/models/requests/get_ticket_conversation_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../data/models/requests/reply_user_ticket_request.dart';
import '../../../data/models/responses/get_ticket_conversation_response.dart';
import '../../../../home/domain/use_cases/upload_file_use_case.dart';
import '../../../domain/use_cases/get_ticket_conversation_use_case.dart';
import '../../../domain/use_cases/reply_ticket.dart';

part 'get_ticket_conversation_state.dart';

/// Owns the ticket conversation: loading it, sending a reply, and the
/// optimistic state of messages that are still on their way to the server.
class GetTicketConversationCubit extends Cubit<GetTicketConversationState> {
  final GetTicketConversationUseCase getTicketConversationUseCase;
  final ReplyUserTicketUseCase replyUserTicketUseCase;
  final UploadFilesUseCase uploadFilesUseCase;

  GetTicketConversationCubit({
    required this.getTicketConversationUseCase,
    required this.replyUserTicketUseCase,
    required this.uploadFilesUseCase,
  }) : super(GetTicketConversationInitial());

  GetTicketConversationResponse? _response;
  final List<PendingMessage> _pending = [];
  int _localIdSeed = 0;
  int _revision = 0;

  /// [silent] keeps the already loaded conversation on screen instead of
  /// flashing a full-screen loader (used for refreshes after sending).
  Future<void> getTicketConversation(String ticketId, {bool silent = false}) async {
    if (!silent || _response == null) {
      emit(GetTicketConversationLoading());
    }

    final eitherPackagesOrFailure = await getTicketConversationUseCase(
      GetTicketConversationRequest(ticketId: ticketId),
    );

    eitherPackagesOrFailure.fold(
      (failure) {
        if (_response != null) {
          // Keep what we already have rather than wiping the thread.
          _emitLoaded();
        } else {
          emit(const GetTicketConversationError(message: 'GetTicketConversationError'));
        }
      },
      (response) async {
        if (response.statusCode != 200) {
          if (_response != null) {
            _emitLoaded();
          } else {
            emit(const GetTicketConversationError(message: 'GetTicketConversationError'));
            emit(GetTicketConversationInitial());
          }
        } else {
          _response = GetTicketConversationResponse.fromJson(response.toJson());
          // The thread coming back from the server already contains them.
          _pending.removeWhere((m) => m.status == PendingMessageStatus.sent);
          _emitLoaded();
        }
      },
    );
  }

  /// Appends the message optimistically, sends it, then refreshes the thread.
  /// Returns true when the server accepted it.
  Future<bool> sendMessage({
    required String ticketId,
    required String message,
    List<File> attachments = const [],
  }) async {
    final text = message.trim();
    if (text.isEmpty && attachments.isEmpty) return false;

    final pending = PendingMessage(
      localId: '${++_localIdSeed}',
      message: text,
      attachments: List.unmodifiable(attachments),
      createdAt: DateTime.now(),
      status: PendingMessageStatus.sending,
    );
    _pending.add(pending);
    _emitLoaded();

    return _send(pending, ticketId);
  }

  /// Re-sends a message that previously failed.
  Future<bool> retryPendingMessage({required String ticketId, required String localId}) async {
    final index = _pending.indexWhere((m) => m.localId == localId);
    if (index == -1) return false;

    final retried = _pending[index].copyWith(
      status: PendingMessageStatus.sending,
      errorMessage: null,
    );
    _pending[index] = retried;
    _emitLoaded();

    return _send(retried, ticketId);
  }

  /// Drops a failed message the user no longer wants to send.
  void discardPendingMessage(String localId) {
    _pending.removeWhere((m) => m.localId == localId);
    _emitLoaded();
  }

  Future<bool> _send(PendingMessage pending, String ticketId) async {
    final id = int.tryParse(ticketId);
    if (id == null) {
      _markFailed(pending.localId, 'رقم التذكرة غير صالح');
      return false;
    }

    var sent = false;
    try {
      // Upload attachments first; ids from a previous attempt are kept on retry.
      final fileIds = [...pending.uploadedFileIds];
      for (var i = fileIds.length; i < pending.attachments.length; i++) {
        final uploaded = await uploadFilesUseCase(pending.attachments[i]);
        final ids = uploaded.fold<List<int>?>(
          (_) => null,
          (r) => r.statusCode == 200 ? r.result : null,
        );
        if (ids == null || ids.isEmpty) {
          _markFailed(pending.localId, 'تعذّر رفع المرفق');
          return false;
        }
        fileIds.addAll(ids);
        _setUploadedIds(pending.localId, fileIds);
      }

      final eitherReplyOrFailure = await replyUserTicketUseCase(
        ReplyUserTicketRequest(
          ticketId: id,
          message: pending.message.isEmpty ? '📎' : pending.message,
          fileIds: fileIds,
        ),
      );

      eitherReplyOrFailure.fold(
        (failure) {
          _markFailed(
            pending.localId,
            failure is ServerFailure ? failure.message.toString() : 'تعذّر إرسال الرسالة',
          );
        },
        (response) {
          if (response.statusCode != 200) {
            _markFailed(pending.localId, response.message);
          } else {
            sent = true;
            _markSent(pending.localId);
          }
        },
      );
    } catch (_) {
      // Never leave the bubble stuck on "sending" if something unexpected throws.
      _markFailed(pending.localId, 'تعذّر إرسال الرسالة');
      return false;
    }

    if (sent) {
      await getTicketConversation(ticketId, silent: true);
    }
    return sent;
  }

  void _setUploadedIds(String localId, List<int> ids) {
    final index = _pending.indexWhere((m) => m.localId == localId);
    if (index == -1) return;
    _pending[index] = _pending[index].copyWith(uploadedFileIds: List.unmodifiable(ids));
  }

  void _markSent(String localId) {
    final index = _pending.indexWhere((m) => m.localId == localId);
    if (index == -1) return;
    _pending[index] = _pending[index].copyWith(status: PendingMessageStatus.sent);
    _emitLoaded();
  }

  void _markFailed(String localId, String error) {
    final index = _pending.indexWhere((m) => m.localId == localId);
    if (index == -1) return;
    _pending[index] = _pending[index].copyWith(
      status: PendingMessageStatus.failed,
      errorMessage: error,
    );
    _emitLoaded();
  }

  void _emitLoaded() {
    if (isClosed) return;
    final response = _response;
    if (response == null) return;
    emit(
      GetTicketConversationLoaded(
        response: response,
        pendingMessages: List.unmodifiable(_pending),
        revision: ++_revision,
      ),
    );
  }
}
