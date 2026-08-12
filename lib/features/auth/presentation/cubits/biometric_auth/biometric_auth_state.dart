part of 'biometric_auth_cubit.dart';

abstract class BiometricAuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BiometricInitial extends BiometricAuthState {}

class BiometricChecking extends BiometricAuthState {}

class BiometricAvailable extends BiometricAuthState {
  final BiometricType type;
  BiometricAvailable({required this.type});

  @override
  List<Object?> get props => [type];
}

class BiometricUnavailable extends BiometricAuthState {}

class BiometricAuthenticating extends BiometricAuthState {}

class BiometricAuthenticated extends BiometricAuthState {}

class BiometricFailed extends BiometricAuthState {}

class BiometricError extends BiometricAuthState {
  final String message;
  BiometricError(this.message);

  @override
  List<Object?> get props => [message];
}
