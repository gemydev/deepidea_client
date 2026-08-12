part of 'send_client_forgot_password_otp_cubit.dart';

abstract class SendClientForgotPasswordOtpState extends Equatable {
  const SendClientForgotPasswordOtpState();

  @override
  List<Object?> get props => [];
}

class SendClientForgotPasswordOtpInitial extends SendClientForgotPasswordOtpState {}

class SendClientForgotPasswordOtpLoading extends SendClientForgotPasswordOtpState {}

class SendClientForgotPasswordOtpLoaded extends SendClientForgotPasswordOtpState {
  final SendClientForgotPasswordOtpResponse response;

  const SendClientForgotPasswordOtpLoaded({required this.response});

  @override
  List<Object?> get props => [response];
}

class SendClientForgotPasswordOtpError extends SendClientForgotPasswordOtpState {
  final String message;

  const SendClientForgotPasswordOtpError({required this.message});

  @override
  List<Object?> get props => [message];
}
