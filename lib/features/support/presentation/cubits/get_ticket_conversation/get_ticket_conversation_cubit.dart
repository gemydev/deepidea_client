import 'package:remotely/features/support/data/models/requests/get_ticket_conversation_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/responses/get_ticket_conversation_response.dart';
import '../../../domain/use_cases/get_ticket_conversation_use_case.dart';

part 'get_ticket_conversation_state.dart';

class GetTicketConversationCubit extends Cubit<GetTicketConversationState> {
  final GetTicketConversationUseCase getTicketConversationUseCase;

  GetTicketConversationCubit({required this.getTicketConversationUseCase})
    : super(GetTicketConversationInitial());

  getTicketConversation(String ticketId) async {
    emit(GetTicketConversationLoading());

    final eitherPackagesOrFailure = await getTicketConversationUseCase(
      GetTicketConversationRequest(ticketId: ticketId),
    );

    eitherPackagesOrFailure.fold(
      (failure) {
        emit(const GetTicketConversationError(message: 'GetTicketConversationError'));
      },
      (response) async {
        if (response.statusCode != 200) {
          emit(const GetTicketConversationError(message: 'GetTicketConversationError'));
          emit(GetTicketConversationInitial());
        } else {
          final getTicketConversationResponse = GetTicketConversationResponse.fromJson(
            response.toJson(),
          );

          emit(GetTicketConversationLoaded(response: getTicketConversationResponse));
        }
      },
    );
  }
}
