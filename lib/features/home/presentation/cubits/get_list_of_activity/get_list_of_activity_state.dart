part of 'get_list_of_activity_cubit.dart';

sealed class GetListOfActivityState extends Equatable {
  const GetListOfActivityState();
}

final class GetListOfActivityInitial extends GetListOfActivityState {
  @override
  List<Object> get props => [];
}

final class GetListOfActivityLoading extends GetListOfActivityState {
  @override
  List<Object> get props => [];
}

class GetListOfActivityLoaded extends GetListOfActivityState {
  final GetListOfActivityResponse response;

  const GetListOfActivityLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class GetListOfActivityError extends GetListOfActivityState {
  final String message;

  const GetListOfActivityError({required this.message});

  @override
  List<Object> get props => [];
}
