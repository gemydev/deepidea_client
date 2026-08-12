import 'dart:developer';

import 'package:remotely/core/helpers/snakbar_manager.dart';
import 'package:dio/dio.dart';

import '../../../core/data/network/dio_client.dart';
import '../../../core/helpers/preferences_manager.dart';
import 'models/requests/set_busy_state.dart';
import 'models/requests/set_online.dart';
import 'models/responses/available_supporter.dart';

class CallApi {
  //static const String baseUrl = 'http://aap-soloutions.com';
  static const String baseUrl = 'https://dev2.newgooobig.com';

  static String availableSupporter(String clientId) =>
      '$baseUrl/api/Calls/availableSupporter?clientId=$clientId';

  static String setBusyState() => '$baseUrl/api/Calls/setBusyState';

  static String setOnline() => '$baseUrl/api/Calls/setOnline';
}

class CallApiService {
  final NetworkClient networkClient;

  CallApiService(this.networkClient);

  /// Coalesces parallel callers (e.g. rapid taps) into one network request.
  Future<AvailableSupportResponse>? _availableSupporterInFlight;

  Future<AvailableSupportResponse> getAvailableSupporter() async {
    final inFlight = _availableSupporterInFlight;
    if (inFlight != null) return inFlight;

    final future = _loadAvailableSupporter();
    _availableSupporterInFlight = future;
    try {
      return await future;
    } finally {
      if (identical(_availableSupporterInFlight, future)) {
        _availableSupporterInFlight = null;
      }
    }
  }

  Future<AvailableSupportResponse> _loadAvailableSupporter() async {
    bool isSupportChatOpend =
        TpPreferencesManager.retrieveBool(TpPreferencesManager.supportChatOpend) ?? false;

    if (isSupportChatOpend) {
      return AvailableSupportResponse(
        autoId: TpPreferencesManager.retrieveInt(TpPreferencesManager.supporterId) ?? 0,
        fullName: TpPreferencesManager.retrieveString(TpPreferencesManager.supporterFullName) ?? '',
        mobileNo: "",
        email: "",
      );
    } else {
      try {
        final clientId =
            TpPreferencesManager.retrieveString(TpPreferencesManager.userId) ?? '';
        final response = await networkClient.getData(
          endpoint: CallApi.availableSupporter(clientId),
        );

        log("Response: $response");
        TpPreferencesManager.saveBool(TpPreferencesManager.supportChatOpend, true);
        TpPreferencesManager.saveInt(TpPreferencesManager.supporterId, response['autoId'] ?? 0);
        TpPreferencesManager.saveString(
          TpPreferencesManager.supporterFullName,
          response['fullName'] ?? '',
        );

        return AvailableSupportResponse.fromJson(response);
      } on DioException catch (e) {
        // ---------------------------
        // 1) Read status code
        // ---------------------------
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;

        log("❌ Bad Response: $statusCode");
        log("Response: ${e.response?.data}");

        // ---------------------------
        // 2) Extract message returned from server
        // ---------------------------
        final message = data is Map && data['message'] != null
            ? data['message'].toString()
            : "حدث خطأ غير متوقع. حاول مرة أخرى.";

        // ---------------------------
        // 3) Show toast
        // ---------------------------
        AppSnackBar.error(message);

        // ---------------------------
        // 4) Throw custom exception
        // ---------------------------
        throw Exception(message);
      } catch (e) {
        // أي خطأ غير Dio
        AppSnackBar.error("حدث خطأ أثناء الاتصال بالسيرفر");
        throw Exception("Unexpected error: $e");
      }
    }
  }

  Future<void> setBusyState(SetBusyStateRequest request) async {
    await networkClient.postData(endpoint: CallApi.setBusyState(), query: request.toJson());
  }

  Future<void> setOnline(SetOnlineRequest request) async {
    await networkClient.postData(endpoint: CallApi.setOnline(), query: request.toJson());
  }
}
