import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/get_all_ticket_faq_response.dart';
import '../repository/support_repository.dart';

class GetAllTicketFaqUseCase implements UseCase<GetAllTicketFaqResponse, Unit> {
  const GetAllTicketFaqUseCase({required this.supportRepository});

  final SupportRepository supportRepository;

  @override
  Future<Either<Failure, GetAllTicketFaqResponse>> call(Unit unit) async {
    return supportRepository.getAllTicketFAQ();
  }
}
