part of 'get_packages_cubit.dart';

sealed class GetPackagesState extends Equatable {
  const GetPackagesState();
}

final class GetPackagesInitial extends GetPackagesState {
  @override
  List<Object> get props => [];
}

final class GetPackagesLoading extends GetPackagesState {
  @override
  List<Object> get props => [];
}

class GetPackagesLoaded extends GetPackagesState {
  final GetPackagesResponse response;

  const GetPackagesLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class GetPackagesError extends GetPackagesState {
  final String message;

  const GetPackagesError({required this.message});

  @override
  List<Object> get props => [];
}
