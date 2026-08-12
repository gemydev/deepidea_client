import 'dart:developer';

import 'package:remotely/features/auth/data/models/requests/reset_client_password_with_otp_request.dart';
import 'package:remotely/features/auth/data/models/requests/send_client_forgot_password_otp_request.dart';
import 'package:remotely/features/auth/data/models/requests/send_otp_verification_request.dart';
import 'package:remotely/features/auth/data/models/requests/verify_otp.dart';
import 'package:remotely/features/auth/data/models/responses/reset_client_password_with_otp_response.dart';
import 'package:remotely/features/auth/data/models/responses/send_client_forgot_password_otp_response.dart';
import 'package:remotely/features/auth/data/models/responses/send_otp_verification.dart';
import 'package:remotely/features/auth/data/models/responses/verify_otp.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/data/network/api.dart';
import '../../../../core/data/network/dio_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/requests/login_request.dart';
import '../models/responses/logout_response.dart';
import '../models/responses/login_response.dart';

abstract class AuthDataSource {
  login(LoginRequest loginRequest);

  logout();

  sendOtpVerification(SendOtpVerificationRequest sendOtpVerificationRequest);

  verifyOtp(VerifyOtpRequest request);

  Future<SendClientForgotPasswordOtpResponse> sendClientForgotPasswordOtp(
    SendClientForgotPasswordOtpRequest request,
  );

  Future<ResetClientPasswordWithOtpResponse> resetClientPasswordWithOtp(
    ResetClientPasswordWithOtpRequest request,
  );
}

class AuthDataSourceImp implements AuthDataSource {
  final NetworkClient networkClient;
  final SharedPreferences prefs;

  AuthDataSourceImp({required this.networkClient, required this.prefs});

  @override
  login(LoginRequest loginRequest) async {
    try {
      Map<String, dynamic> response = await networkClient.postData(
        endpoint: Api.login(),
        query: loginRequest.toJson(),
        options: Options(
          headers: {
            'lang': loginRequest.lang ?? 'Ar',
            'siteId': loginRequest.siteID ?? Api.portalSiteId,
          },
        ),
      );

      final LoginResponse loginResponse = LoginResponse.fromJson(response);

      log(loginResponse.toString());

      return loginResponse;
    } on DioException catch (e) {
      throw ServerException(message: "Server Exception: ${e.toString()}");
    }
  }

  @override
  logout() async {
    try {
      Map<String, dynamic> response = await networkClient.postData(endpoint: Api.logout());
      final LogoutResponse logoutResponse = LogoutResponse.fromJson(response);

      return logoutResponse;
    } on DioException catch (e) {
      throw ServerException(message: "Server Exception: ${e.toString()}");
    }
  }

  @override
  Future<SendOtpVerificationResponse> sendOtpVerification(
    SendOtpVerificationRequest sendOtpVerificationRequest,
  ) async {
    final Dio dio = Dio();

    log(sendOtpVerificationRequest.toString());

    try {
      final Response response = await dio.post(
        Api.baseUrl + Api.sendOtpVerification(),
        data: sendOtpVerificationRequest.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      log(response.toString());
      return SendOtpVerificationResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(message: 'Server Exception: ${e.message}');
    }
  }

  @override
  verifyOtp(VerifyOtpRequest request) async {
    final Dio dio = Dio();

    log(request.toString());

    try {
      final Response response = await dio.post(
        Api.baseUrl + Api.verifyOtp(),
        data: request.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      log(response.toString());

      return VerifyOtpResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(message: 'Server Exception: ${e.message}');
    }
  }

  @override
  Future<SendClientForgotPasswordOtpResponse> sendClientForgotPasswordOtp(
    SendClientForgotPasswordOtpRequest request,
  ) async {
    try {
      final Map<String, dynamic> response = await networkClient.postPortalGuestData(
        endpoint: Api.sendClientForgotPasswordOtp(),
        data: request.toJson(),
      );
      return SendClientForgotPasswordOtpResponse.fromJson(response);
    } on DioException catch (e) {
      throw ServerException(message: _messageFromDio(e));
    }
  }

  @override
  Future<ResetClientPasswordWithOtpResponse> resetClientPasswordWithOtp(
    ResetClientPasswordWithOtpRequest request,
  ) async {
    try {
      final Map<String, dynamic> response = await networkClient.postPortalGuestData(
        endpoint: Api.resetClientPasswordWithOtp(),
        data: request.toJson(),
      );
      return ResetClientPasswordWithOtpResponse.fromJson(response);
    } on DioException catch (e) {
      throw ServerException(message: _messageFromDio(e));
    }
  }

  String _messageFromDio(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final map = Map<dynamic, dynamic>.from(data);
      final msg = map['statusMessage'] ?? map['message'];
      if (msg != null && msg.toString().trim().isNotEmpty) {
        return msg.toString();
      }
    }
    return e.message ?? 'Server Exception';
  }
}
