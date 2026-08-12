part of 'send_otp_verification_cubit.dart';

abstract class SendOtpVerificationState extends Equatable {
  const SendOtpVerificationState();

  @override
  List<Object?> get props => [];
}

class SendOtpVerificationInitial extends SendOtpVerificationState {}

class SendOtpVerificationLoading extends SendOtpVerificationState {}

class SendOtpVerificationLoaded extends SendOtpVerificationState {
  final SendOtpVerificationResponse response;

  const SendOtpVerificationLoaded({required this.response});

  @override
  List<Object?> get props => [response];
}

class SendOtpVerificationError extends SendOtpVerificationState {
  final String message;

  const SendOtpVerificationError({required this.message});

  @override
  List<Object?> get props => [message];
}
