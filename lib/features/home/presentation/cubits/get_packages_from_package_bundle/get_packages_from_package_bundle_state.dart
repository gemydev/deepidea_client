part of 'get_packages_from_package_bundle_cubit.dart';

sealed class GetPackagesFromPackageBundleState extends Equatable {
  const GetPackagesFromPackageBundleState();
}

final class GetPackagesFromPackageBundleInitial
    extends GetPackagesFromPackageBundleState {
  @override
  List<Object> get props => [];
}

final class GetPackagesFromPackageBundleLoading
    extends GetPackagesFromPackageBundleState {
  @override
  List<Object> get props => [];
}

class GetPackagesFromPackageBundleLoaded
    extends GetPackagesFromPackageBundleState {
  final GetPackagesFromPackageBundleResponse response;

  const GetPackagesFromPackageBundleLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class GetPackagesFromPackageBundleError
    extends GetPackagesFromPackageBundleState {
  final String message;

  const GetPackagesFromPackageBundleError({required this.message});

  @override
  List<Object> get props => [];
}
