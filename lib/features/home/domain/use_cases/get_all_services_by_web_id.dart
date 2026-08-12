import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/get_all_services_by_web_id_response.dart';
import '../repository/home_repository.dart';

class GetAllServicesByWebIdUseCase
    implements UseCase<GetAllServicesByWebIdResponse, Unit> {
  final HomeRepository homeRepository;

  const GetAllServicesByWebIdUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, GetAllServicesByWebIdResponse>> call(Unit unit) async {
    return homeRepository.getAllServicesByWebId();
  }
}
