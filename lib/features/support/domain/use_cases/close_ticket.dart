import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/close_ticket.dart';
import '../repository/support_repository.dart';

class CloseTicketUseCase implements UseCase<CloseTicketResponse, String> {
  final SupportRepository supportRepository;

  const CloseTicketUseCase({required this.supportRepository});

  @override
  Future<Either<Failure, CloseTicketResponse>> call(String ticketId) async {
    return supportRepository.closeTicket(ticketId);
  }
}
