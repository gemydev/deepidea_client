import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/get_registered_services_and_packages_response.dart';
import '../repository/home_repository.dart';

class GetRegisteredServicesAndPackagesUseCase implements UseCase<GetRegisteredServicesAndPackagesResponse, Unit> {
  final HomeRepository homeRepository;

  const GetRegisteredServicesAndPackagesUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, GetRegisteredServicesAndPackagesResponse>> call(Unit unit) async {
    return homeRepository.getRegisteredServicesAndPackages();
  }
}
