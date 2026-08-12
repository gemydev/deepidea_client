import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/requests/get_service_from_service_id.dart';
import '../../data/models/responses/get_service_from_service_id.dart';
import '../repository/home_repository.dart';

class GetServiceFromServiceIdUseCase
    implements
        UseCase<
          GetServiceFromServiceIdResponse,
          GetServiceFromServiceIdRequest
        > {
  final HomeRepository homeRepository;

  const GetServiceFromServiceIdUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, GetServiceFromServiceIdResponse>> call(
    GetServiceFromServiceIdRequest request,
  ) async {
    return homeRepository.getServiceFromServiceId(request);
  }
}
