part of 'get_all_tickets_cubit.dart';

abstract class GetAllTicketsState extends Equatable {
  const GetAllTicketsState();

  @override
  List<Object?> get props => [];
}

class GetAllTicketsInitial extends GetAllTicketsState {}

class GetAllTicketsLoading extends GetAllTicketsState {}

class GetAllTicketsError extends GetAllTicketsState {
  final String message;

  const GetAllTicketsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetAllTicketsLoaded extends GetAllTicketsState {
  final GetAllTicketsResponse response;
  final List<Ticket> currentTickets;
  final List<Ticket> closedTickets;
  final List<Ticket> underProgressTickets;

  const GetAllTicketsLoaded({
    required this.closedTickets,
    required this.underProgressTickets,
    required this.response,
    required this.currentTickets,
  });

  @override
  List<Object?> get props =>
      [response, currentTickets, closedTickets, underProgressTickets];
}
