part of 'verify_otp_cubit.dart';

abstract class VerifyOtpState extends Equatable {
  const VerifyOtpState();
}

class VerifyOtpInitial extends VerifyOtpState {
  @override
  List<Object> get props => [];
}

class VerifyOtpLoading extends VerifyOtpState {
  @override
  List<Object> get props => [];
}

class VerifyOtpLoaded extends VerifyOtpState {
  final VerifyOtpResponse response;

  const VerifyOtpLoaded({required this.response});

  @override
  List<Object> get props => [];
}

class VerifyOtpError extends VerifyOtpState {
  final String message;

  const VerifyOtpError({required this.message});

  @override
  List<Object> get props => [];
}
