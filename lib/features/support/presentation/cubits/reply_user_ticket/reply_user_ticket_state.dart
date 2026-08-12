part of 'reply_user_ticket_cubit.dart';

abstract class ReplyUserTicketState extends Equatable {
  const ReplyUserTicketState();
}

class ReplyUserTicketInitial extends ReplyUserTicketState {
  @override
  List<Object> get props => [];
}

class ReplyUserTicketLoading extends ReplyUserTicketState {
  @override
  List<Object> get props => [];
}

class ReplyUserTicketLoaded extends ReplyUserTicketState {
  final ReplyUserTicketResponse response;

  const ReplyUserTicketLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class ReplyUserTicketError extends ReplyUserTicketState {
  final String message;

  const ReplyUserTicketError({required this.message});

  @override
  List<Object> get props => [];
}
