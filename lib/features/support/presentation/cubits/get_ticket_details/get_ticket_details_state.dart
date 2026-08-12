part of 'get_ticket_details_cubit.dart';

abstract class GetTicketDetailsState extends Equatable {
  const GetTicketDetailsState();
}

class GetTicketDetailsInitial extends GetTicketDetailsState {
  @override
  List<Object> get props => [];
}

class GetTicketDetailsLoading extends GetTicketDetailsState {
  @override
  List<Object> get props => [];
}

class GetTicketDetailsLoaded extends GetTicketDetailsState {
  final GetTicketDetailsResponse response;

  const GetTicketDetailsLoaded({required this.response});

  @override
  List<Object> get props => [response];
}

class GetTicketDetailsError extends GetTicketDetailsState {
  final String message;

  const GetTicketDetailsError({required this.message});

  @override
  List<Object> get props => [];
}
