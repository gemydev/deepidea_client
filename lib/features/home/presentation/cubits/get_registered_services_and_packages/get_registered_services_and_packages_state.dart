part of 'get_registered_services_and_packages_cubit.dart';

sealed class GetRegisteredServicesAndPackagesState extends Equatable {
  const GetRegisteredServicesAndPackagesState();
}

final class GetRegisteredServicesAndPackagesInitial extends GetRegisteredServicesAndPackagesState {
  @override
  List<Object> get props => [];
}

final class GetRegisteredServicesAndPackagesLoading extends GetRegisteredServicesAndPackagesState {
  @override
  List<Object> get props => [];
}

class GetRegisteredServicesAndPackagesLoaded extends GetRegisteredServicesAndPackagesState {
  final GetRegisteredServicesAndPackagesResponse response;

  const GetRegisteredServicesAndPackagesLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class GetRegisteredServicesAndPackagesError extends GetRegisteredServicesAndPackagesState {
  final String message;

  const GetRegisteredServicesAndPackagesError({required this.message});

  @override
  List<Object> get props => [];
}
