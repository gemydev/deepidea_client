part of 'get_service_from_service_id_cubit.dart';

sealed class GetServiceFromServiceIdState extends Equatable {
  const GetServiceFromServiceIdState();
}

final class GetServiceFromServiceIdInitial
    extends GetServiceFromServiceIdState {
  @override
  List<Object> get props => [];
}

final class GetServiceFromServiceIdLoading
    extends GetServiceFromServiceIdState {
  @override
  List<Object> get props => [];
}

class GetServiceFromServiceIdLoaded extends GetServiceFromServiceIdState {
  final GetServiceFromServiceIdResponse response;

  const GetServiceFromServiceIdLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class GetServiceFromServiceIdError extends GetServiceFromServiceIdState {
  final String message;

  const GetServiceFromServiceIdError({required this.message});

  @override
  List<Object> get props => [];
}
