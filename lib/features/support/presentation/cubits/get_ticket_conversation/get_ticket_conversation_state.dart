part of 'get_ticket_conversation_cubit.dart';

enum PendingMessageStatus { sending, sent, failed }

/// A message the user sent from this screen, shown in the thread before the
/// server confirms it.
class PendingMessage extends Equatable {
  final String localId;
  final String message;
  final DateTime createdAt;
  final PendingMessageStatus status;
  final String? errorMessage;

  /// Local files attached to the message, and the ids of those already uploaded.
  final List<File> attachments;
  final List<int> uploadedFileIds;

  const PendingMessage({
    required this.localId,
    required this.message,
    required this.createdAt,
    required this.status,
    this.errorMessage,
    this.attachments = const [],
    this.uploadedFileIds = const [],
  });

  PendingMessage copyWith({
    PendingMessageStatus? status,
    String? errorMessage,
    List<int>? uploadedFileIds,
  }) {
    return PendingMessage(
      localId: localId,
      message: message,
      createdAt: createdAt,
      status: status ?? this.status,
      errorMessage: errorMessage,
      attachments: attachments,
      uploadedFileIds: uploadedFileIds ?? this.uploadedFileIds,
    );
  }

  @override
  List<Object?> get props =>
      [localId, message, createdAt, status, errorMessage, attachments, uploadedFileIds];
}

abstract class GetTicketConversationState extends Equatable {
  const GetTicketConversationState();
}

class GetTicketConversationInitial extends GetTicketConversationState {
  @override
  List<Object> get props => [];
}

class GetTicketConversationLoading extends GetTicketConversationState {
  @override
  List<Object> get props => [];
}

class GetTicketConversationLoaded extends GetTicketConversationState {
  final GetTicketConversationResponse response;
  final List<PendingMessage> pendingMessages;

  /// Bumped on every emit so equal-looking reloads still rebuild the UI.
  final int revision;

  const GetTicketConversationLoaded({
    required this.response,
    this.pendingMessages = const [],
    this.revision = 0,
  });

  @override
  List<Object> get props => [revision];
}

class GetTicketConversationError extends GetTicketConversationState {
  final String message;

  const GetTicketConversationError({required this.message});

  @override
  List<Object> get props => [message];
}
