part of 'get_list_of_packages_with_fav_cubit.dart';

sealed class GetServicesListOfPackagesWithFavState extends Equatable {
  const GetServicesListOfPackagesWithFavState();
}

final class GetServicesListOfPackagesWithFavInitial
    extends GetServicesListOfPackagesWithFavState {
  @override
  List<Object> get props => [];
}

final class GetServicesListOfPackagesWithFavLoading
    extends GetServicesListOfPackagesWithFavState {
  @override
  List<Object> get props => [];
}

class GetServicesListOfPackagesWithFavLoaded
    extends GetServicesListOfPackagesWithFavState {
  final GetServicesListOfPackagesWithFavResponse response;

  const GetServicesListOfPackagesWithFavLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class GetServicesListOfPackagesWithFavError
    extends GetServicesListOfPackagesWithFavState {
  final String message;

  const GetServicesListOfPackagesWithFavError({required this.message});

  @override
  List<Object> get props => [];
}
