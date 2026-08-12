part of 'reset_client_password_with_otp_cubit.dart';

abstract class ResetClientPasswordWithOtpState extends Equatable {
  const ResetClientPasswordWithOtpState();

  @override
  List<Object?> get props => [];
}

class ResetClientPasswordWithOtpInitial extends ResetClientPasswordWithOtpState {}

class ResetClientPasswordWithOtpLoading extends ResetClientPasswordWithOtpState {}

class ResetClientPasswordWithOtpLoaded extends ResetClientPasswordWithOtpState {
  final ResetClientPasswordWithOtpResponse response;

  const ResetClientPasswordWithOtpLoaded({required this.response});

  @override
  List<Object?> get props => [response];
}

class ResetClientPasswordWithOtpError extends ResetClientPasswordWithOtpState {
  final String message;

  const ResetClientPasswordWithOtpError({required this.message});

  @override
  List<Object?> get props => [message];
}
