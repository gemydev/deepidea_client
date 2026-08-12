import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/get_all_tickets_response.dart';
import '../repository/support_repository.dart';

class GetAllTicketsUseCase implements UseCase<GetAllTicketsResponse, Unit> {
  final SupportRepository supportRepository;

  const GetAllTicketsUseCase({required this.supportRepository});

  @override
  Future<Either<Failure, GetAllTicketsResponse>> call(Unit unit) async {
    return supportRepository.getAllTickets();
  }
}
