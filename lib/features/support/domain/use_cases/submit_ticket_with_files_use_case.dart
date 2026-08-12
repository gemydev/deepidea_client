import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/requests/submit_ticket_with_files_request.dart';
import '../../data/models/responses/submit_ticket_with_files_response.dart';
import '../repository/support_repository.dart';

class SubmitTicketWithFilesUseCase
    implements UseCase<SubmitTicketWithFilesResponse, TicketSubmissionRequest> {
  final SupportRepository supportRepository;

  const SubmitTicketWithFilesUseCase({required this.supportRepository});

  @override
  Future<Either<Failure, SubmitTicketWithFilesResponse>> call(
      TicketSubmissionRequest request) async {
    return supportRepository.submitTicketWithFiles(request);
  }
}
