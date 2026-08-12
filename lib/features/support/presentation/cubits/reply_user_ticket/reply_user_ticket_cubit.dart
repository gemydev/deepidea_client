import 'package:remotely/core/error/failure.dart';
import 'package:remotely/features/support/data/models/requests/reply_user_ticket_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/snakbar_manager.dart';
import '../../../data/models/responses/reply_user_ticket.dart';
import '../../../domain/use_cases/reply_ticket.dart';

part 'reply_user_ticket_state.dart';

class ReplyUserTicketCubit extends Cubit<ReplyUserTicketState> {
  final ReplyUserTicketUseCase replyUserTicketUseCase;

  ReplyUserTicketCubit({required this.replyUserTicketUseCase}) : super(ReplyUserTicketInitial());

  replyUserTicket(ReplyUserTicketRequest request) async {
    emit(ReplyUserTicketLoading());

    final eitherPackagesOrFailure = await replyUserTicketUseCase(request);

    eitherPackagesOrFailure.fold(
      (failure) {
        emit(const ReplyUserTicketError(message: 'ReplyUserTicketError'));
        if (failure is ServerFailure) {
          AppSnackBar.error(failure.message.toString());
        }
      },
      (response) async {
        if (response.statusCode != 200) {
          emit(const ReplyUserTicketError(message: 'ReplyUserTicketError'));
          AppSnackBar.error(response.message);
          emit(ReplyUserTicketInitial());
        } else {
          final replyUserTicketResponse = ReplyUserTicketResponse.fromJson(response.toJson());
          AppSnackBar.success("تم الرد بنجاح");
          emit(ReplyUserTicketLoaded(response: replyUserTicketResponse));
        }
      },
    );
  }
}
