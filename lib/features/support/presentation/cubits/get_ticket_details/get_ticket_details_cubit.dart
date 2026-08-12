import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/responses/get_ticket_details_response.dart';
import '../../../domain/use_cases/get_ticket_details_use_case.dart';

part 'get_ticket_details_state.dart';

class GetTicketDetailsCubit extends Cubit<GetTicketDetailsState> {
  final GetTicketDetailsUseCase getTicketDetailsUseCase;

  GetTicketDetailsCubit({required this.getTicketDetailsUseCase})
      : super(GetTicketDetailsInitial());

  getTicketDetails(String ticketId) async {
    emit(GetTicketDetailsLoading());

    final eitherPackagesOrFailure = await getTicketDetailsUseCase(ticketId);

    eitherPackagesOrFailure.fold((failure) {
      emit(const GetTicketDetailsError(message: 'GetTicketDetailsError'));
    }, (GetTicketDetailsResponse response) {
      if (response.statusCode != 200) {
        emit(const GetTicketDetailsError(message: 'GetTicketDetailsError'));
      } else {
        emit(GetTicketDetailsLoaded(response: response));
      }
    });
  }
}
