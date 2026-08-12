import 'package:equatable/equatable.dart';

import '../../../data/models/responses/get_service_details_response.dart';

sealed class GetServiceDetailsState extends Equatable {
  const GetServiceDetailsState();
}

final class GetServiceDetailsInitial extends GetServiceDetailsState {
  @override
  List<Object> get props => [];
}

final class GetServiceDetailsLoading extends GetServiceDetailsState {
  @override
  List<Object> get props => [];
}

class GetServiceDetailsLoaded extends GetServiceDetailsState {
  final GetServiceDetailsResponse response;

  const GetServiceDetailsLoaded({required this.response});

  @override
  List<Object> get props => [response];
}

class GetServiceDetailsError extends GetServiceDetailsState {
  final String message;

  const GetServiceDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}
