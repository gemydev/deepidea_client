part of 'get_ticket_conversation_cubit.dart';

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

  const GetTicketConversationLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class GetTicketConversationError extends GetTicketConversationState {
  final String message;

  const GetTicketConversationError({required this.message});

  @override
  List<Object> get props => [];
}
