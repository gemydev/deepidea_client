import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/requests/get_packages_from_backage_bundel.dart';
import '../../data/models/responses/get_packages_from_package_bundle_response.dart';
import '../repository/home_repository.dart';

class GetPackagesFromPackageBundleUseCase
    implements
        UseCase<
          GetPackagesFromPackageBundleResponse,
          GetPackagesFromPackageBundleRequest
        > {
  final HomeRepository homeRepository;

  const GetPackagesFromPackageBundleUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, GetPackagesFromPackageBundleResponse>> call(
    GetPackagesFromPackageBundleRequest request,
  ) async {
    return homeRepository.getPackagesFromPackageBundle(request);
  }
}
