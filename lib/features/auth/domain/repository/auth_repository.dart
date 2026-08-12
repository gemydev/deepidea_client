import 'package:remotely/features/auth/data/models/requests/reset_client_password_with_otp_request.dart';
import 'package:remotely/features/auth/data/models/requests/send_client_forgot_password_otp_request.dart';
import 'package:remotely/features/auth/data/models/requests/send_otp_verification_request.dart';
import 'package:remotely/features/auth/data/models/requests/verify_otp.dart';
import 'package:remotely/features/auth/data/models/responses/reset_client_password_with_otp_response.dart';
import 'package:remotely/features/auth/data/models/responses/send_client_forgot_password_otp_response.dart';
import 'package:remotely/features/auth/data/models/responses/send_otp_verification.dart';
import 'package:remotely/features/auth/data/models/responses/verify_otp.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/requests/login_request.dart';
import '../../data/models/responses/logout_response.dart';
import '../../data/models/responses/login_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest loginRequest);

  Future<Either<Failure, LogoutResponse>> logout();

  Future<Either<Failure, SendOtpVerificationResponse>> sendOtpVerification(
    SendOtpVerificationRequest request,
  );

  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(VerifyOtpRequest request);

  Future<Either<Failure, SendClientForgotPasswordOtpResponse>> sendClientForgotPasswordOtp(
    SendClientForgotPasswordOtpRequest request,
  );

  Future<Either<Failure, ResetClientPasswordWithOtpResponse>> resetClientPasswordWithOtp(
    ResetClientPasswordWithOtpRequest request,
  );
}
