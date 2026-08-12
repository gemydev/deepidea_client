part of 'get_all_services_by_web_id_cubit.dart';

sealed class GetAllServicesByWebIdState extends Equatable {
  const GetAllServicesByWebIdState();
}

final class GetAllServicesByWebIdInitial extends GetAllServicesByWebIdState {
  @override
  List<Object> get props => [];
}

final class GetAllServicesByWebIdLoading extends GetAllServicesByWebIdState {
  @override
  List<Object> get props => [];
}

class GetAllServicesByWebIdLoaded extends GetAllServicesByWebIdState {
  final GetAllServicesByWebIdResponse response;

  const GetAllServicesByWebIdLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class GetAllServicesByWebIdError extends GetAllServicesByWebIdState {
  final String message;

  const GetAllServicesByWebIdError({required this.message});

  @override
  List<Object> get props => [];
}
