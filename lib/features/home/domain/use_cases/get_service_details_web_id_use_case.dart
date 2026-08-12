import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/get_service_details_response.dart';
import '../repository/home_repository.dart';

class GetServiceDetailsByWebIdUseCase
    implements UseCase<GetServiceDetailsResponse, String> {
  final HomeRepository homeRepository;

  const GetServiceDetailsByWebIdUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, GetServiceDetailsResponse>> call(String id) async {
    return homeRepository.getServiceDetailsByWebId(id);
  }
}
