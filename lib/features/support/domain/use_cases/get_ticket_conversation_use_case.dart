import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/requests/get_ticket_conversation_request.dart';
import '../../data/models/responses/get_ticket_conversation_response.dart';
import '../repository/support_repository.dart';

class GetTicketConversationUseCase
    implements
        UseCase<GetTicketConversationResponse, GetTicketConversationRequest> {
  final SupportRepository supportRepository;

  const GetTicketConversationUseCase({required this.supportRepository});

  @override
  Future<Either<Failure, GetTicketConversationResponse>> call(
      GetTicketConversationRequest request) async {
    return supportRepository.getTicketConversation(request);
  }
}
