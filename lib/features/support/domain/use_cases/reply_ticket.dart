import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/requests/reply_user_ticket_request.dart';
import '../../data/models/responses/reply_user_ticket.dart';
import '../repository/support_repository.dart';

class ReplyUserTicketUseCase
    implements UseCase<ReplyUserTicketResponse, ReplyUserTicketRequest> {
  final SupportRepository supportRepository;

  const ReplyUserTicketUseCase({required this.supportRepository});

  @override
  Future<Either<Failure, ReplyUserTicketResponse>> call(
      ReplyUserTicketRequest request) async {
    return supportRepository.replyUserTicket(request);
  }
}
