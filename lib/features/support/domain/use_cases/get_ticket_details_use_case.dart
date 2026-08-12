import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/get_ticket_details_response.dart';
import '../repository/support_repository.dart';

class GetTicketDetailsUseCase
    implements UseCase<GetTicketDetailsResponse, String> {
  final SupportRepository supportRepository;

  const GetTicketDetailsUseCase({required this.supportRepository});

  @override
  Future<Either<Failure, GetTicketDetailsResponse>> call(
      String ticketId) async {
    return supportRepository.getTicketDetails(ticketId);
  }
}
