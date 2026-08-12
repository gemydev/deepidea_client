part of 're_open_ticket_cubit.dart';

abstract class ReOpenTicketState extends Equatable {
  const ReOpenTicketState();
}

class ReOpenTicketInitial extends ReOpenTicketState {
  @override
  List<Object> get props => [];
}

class ReOpenTicketLoading extends ReOpenTicketState {
  @override
  List<Object> get props => [];
}

class ReOpenTicketLoaded extends ReOpenTicketState {
  final ReOpenTicketResponse response;

  const ReOpenTicketLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class ReOpenTicketError extends ReOpenTicketState {
  final String message;

  const ReOpenTicketError({required this.message});

  @override
  List<Object> get props => [];
}
