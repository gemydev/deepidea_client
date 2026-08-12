import 'package:remotely/features/auth/data/models/requests/reset_client_password_with_otp_request.dart';
import 'package:remotely/features/auth/data/models/requests/send_client_forgot_password_otp_request.dart';
import 'package:remotely/features/auth/data/models/requests/send_otp_verification_request.dart';
import 'package:remotely/features/auth/data/models/requests/verify_otp.dart';
import 'package:remotely/features/auth/data/models/responses/reset_client_password_with_otp_response.dart';
import 'package:remotely/features/auth/data/models/responses/send_client_forgot_password_otp_response.dart';
import 'package:remotely/features/auth/data/models/responses/send_otp_verification.dart';
import 'package:remotely/features/auth/data/models/responses/verify_otp.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_data_source.dart';
import '../models/requests/login_request.dart';
import '../models/responses/logout_response.dart';
import '../models/responses/login_response.dart';

class AuthRepositoryImp extends AuthRepository {
  late AuthDataSource authDataSource;

  AuthRepositoryImp({required this.authDataSource});

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest loginRequest) async {
    try {
      final data = await authDataSource.login(loginRequest);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, LogoutResponse>> logout() async {
    try {
      final data = await authDataSource.logout();

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SendOtpVerificationResponse>> sendOtpVerification(
    SendOtpVerificationRequest request,
  ) async {
    try {
      final data = await authDataSource.sendOtpVerification(request);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(VerifyOtpRequest request) async {
    try {
      final data = await authDataSource.verifyOtp(request);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, SendClientForgotPasswordOtpResponse>> sendClientForgotPasswordOtp(
    SendClientForgotPasswordOtpRequest request,
  ) async {
    try {
      final data = await authDataSource.sendClientForgotPasswordOtp(request);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, ResetClientPasswordWithOtpResponse>> resetClientPasswordWithOtp(
    ResetClientPasswordWithOtpRequest request,
  ) async {
    try {
      final data = await authDataSource.resetClientPasswordWithOtp(request);

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
