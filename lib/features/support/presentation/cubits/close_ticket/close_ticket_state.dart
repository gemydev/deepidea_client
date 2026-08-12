part of 'close_ticket_cubit.dart';

abstract class CloseTicketState extends Equatable {
  const CloseTicketState();
}

class CloseTicketInitial extends CloseTicketState {
  @override
  List<Object> get props => [];
}

class CloseTicketLoading extends CloseTicketState {
  @override
  List<Object> get props => [];
}

class CloseTicketLoaded extends CloseTicketState {
  final CloseTicketResponse response;

  const CloseTicketLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class CloseTicketError extends CloseTicketState {
  final String message;

  const CloseTicketError({required this.message});

  @override
  List<Object> get props => [];
}
