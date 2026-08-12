part of 'logout_cubit.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();
}

class LogoutInitial extends LogoutState {
  @override
  List<Object> get props => [];
}

class LogoutLoading extends LogoutState {
  @override
  List<Object> get props => [];
}

class LogoutLoaded extends LogoutState {
  final LogoutResponse response;

  const LogoutLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class LogoutError extends LogoutState {
  final String message;

  const LogoutError({required this.message});

  @override
  List<Object> get props => [];
}
