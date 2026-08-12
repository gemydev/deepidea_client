import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/models/usecase.dart';
import '../../data/models/responses/get_services_list_of_packages_with_fav_response.dart';
import '../repository/home_repository.dart';

class GetServicesListOfPackagesWithFavUseCase
    implements UseCase<GetServicesListOfPackagesWithFavResponse, String> {
  final HomeRepository homeRepository;

  const GetServicesListOfPackagesWithFavUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, GetServicesListOfPackagesWithFavResponse>> call(
      String id) async {
    return homeRepository.getServicesListOfPackagesWithFav(id);
  }
}
