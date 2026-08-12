import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/requests/re_open_ticket_request.dart';
import '../../data/models/responses/re_open_ticket_response.dart';
import '../repository/support_repository.dart';

class ReOpenTicketUseCase
    implements UseCase<ReOpenTicketResponse, ReOpenTicketRequest> {
  final SupportRepository supportRepository;

  const ReOpenTicketUseCase({required this.supportRepository});

  @override
  Future<Either<Failure, ReOpenTicketResponse>> call(
      ReOpenTicketRequest request) async {
    return supportRepository.reOpenTicket(request);
  }
}
