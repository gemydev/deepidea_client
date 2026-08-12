part of 'submit_ticket_with_files_cubit.dart';

abstract class SubmitTicketWithFilesState extends Equatable {
  const SubmitTicketWithFilesState();
}

class SubmitTicketWithFilesInitial extends SubmitTicketWithFilesState {
  @override
  List<Object> get props => [];
}

class SubmitTicketWithFilesLoading extends SubmitTicketWithFilesState {
  @override
  List<Object> get props => [];
}

class SubmitTicketWithFilesLoaded extends SubmitTicketWithFilesState {
  final SubmitTicketWithFilesResponse response;

  const SubmitTicketWithFilesLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class SubmitTicketWithFilesError extends SubmitTicketWithFilesState {
  final String message;

  const SubmitTicketWithFilesError({required this.message});

  @override
  List<Object> get props => [];
}
