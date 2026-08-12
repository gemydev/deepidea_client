import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:remotely/core/helpers/preferences_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';

class NetworkClient {
  final Dio dio;

  NetworkClient(this.dio) {
    dio.options = BaseOptions(
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      baseUrl: Api.baseUrlPortal,
    );
  }

  String _fullRequestUrl(String pathOrUrl) {
    final trimmed = pathOrUrl.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }
    final base = dio.options.baseUrl;
    final normalizedBase = base.endsWith('/') ? base : '$base/';
    return Uri.parse(normalizedBase).resolve(trimmed).toString();
  }

  /// 🔹 Unified logger for all requests/responses/errors
  void _logRequest(String method, String url, dynamic data, Map<String, dynamic>? headers) {
    final fullUrl = _fullRequestUrl(url);
    log("➡️ [$method] Request -> $fullUrl");
    log("Headers: ${headers ?? {}}");
    log("Body: $data");
  }

  void _logResponse(Response response) {
    final fullUrl = response.requestOptions.uri.toString();
    log("✅ Response [$fullUrl]");
    log("Status code: ${response.statusCode}");
    log("Data: ${response.data}");
  }

  /// Parses common API shapes for a human-readable server message.
  String? _extractServerMessage(dynamic data) {
    if (data == null) return null;
    if (data is String) {
      final t = data.trim();
      return t.isEmpty ? null : t;
    }
    if (data is Map) {
      final map = Map<dynamic, dynamic>.from(data);
      for (final key in ['message', 'error', 'detail', 'title']) {
        final v = map[key];
        if (v != null) {
          final s = v.toString().trim();
          if (s.isNotEmpty) return s;
        }
      }
      final errors = map['errors'];
      if (errors is Map) {
        final parts = <String>[];
        for (final value in errors.values) {
          if (value is List) {
            for (final item in value) {
              parts.add(item.toString());
            }
          } else if (value != null) {
            parts.add(value.toString());
          }
        }
        if (parts.isNotEmpty) return parts.join('; ');
      }
    }
    return null;
  }

  void _logError(DioException e) {
    final fullUrl = e.requestOptions.uri.toString();
    log("❌ Error [$fullUrl] -> ${e.type}");
    log("❌ Error message: ${e.message}");
    log("❌ Error status code: ${e.response?.statusCode}");
    if (e.response != null) {
      log("StatusCode: ${e.response?.statusCode}");
      final body = e.response?.data;
      final serverMessage = _extractServerMessage(body);
      if (serverMessage != null) {
        log("Server message: $serverMessage");
      }
      log("Response: $body");
    } else {
      log("Error details: $e");
    }
  }

  /// 🔹 Retrieve token
  Future<String> _getToken() async {
    return TpPreferencesManager.retrieveString(TpPreferencesManager.authKey) ??
        (await SharedPreferences.getInstance()).getString("token") ??
        "";
  }

  /// GET
  Future<Map<String, dynamic>> getData({
    required String endpoint,
    Options? options,
    Map<String, dynamic>? request,
  }) async {
    final token = await _getToken();
    final headers = {"auth_key": token};
    _logRequest("GET", endpoint, request, headers);

    try {
      final response = await dio.get(
        endpoint,
        data: request,
        options: options ?? Options(headers: headers),
      );
      _logResponse(response);
      return jsonDecode(response.toString());
    } on DioException catch (e) {
      _logError(e);
      _handleDioException(e);
      rethrow;
    }
  }

  /// DELETE
  Future<Map<String, dynamic>> deleteData({required String endpoint, Options? options}) async {
    final token = await _getToken();
    final headers = {"Authorization": "Bearer $token"};
    _logRequest("DELETE", endpoint, null, headers);

    try {
      final response = await dio.delete(
        endpoint,
        options: options ?? Options(receiveDataWhenStatusError: true, headers: headers),
      );
      _logResponse(response);
      return jsonDecode(response.toString());
    } on DioException catch (e) {
      _logError(e);
      _handleDioException(e);
      rethrow;
    }
  }

  /// PUT
  Future<Map<String, dynamic>> putData({
    required String endpoint,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    final token = await _getToken();
    final headers = {"Authorization": "Bearer $token"};
    _logRequest("PUT", endpoint, query, headers);

    try {
      final response = await dio.put(
        endpoint,
        options:
            options ??
            Options(
              responseType: ResponseType.plain,
              receiveDataWhenStatusError: true,
              headers: headers,
            ),
        data: query,
      );
      _logResponse(response);
      return jsonDecode(response.toString());
    } on DioException catch (e) {
      _logError(e);
      _handleDioException(e);
      rethrow;
    }
  }

  /// POST (JSON)
  Future<Map<String, dynamic>> postData({
    required String endpoint,
    dynamic query,
    Options? options,
  }) async {
    final token = await _getToken();
    final headers = {"auth_key": token};
    _logRequest("POST", endpoint, query, headers);

    try {
      final response = await dio.post(
        endpoint,
        options:
            options ??
            Options(
              responseType: ResponseType.json,
              receiveDataWhenStatusError: true,
              headers: headers,
            ),
        data: query,
      );
      _logResponse(response);
      return jsonDecode(response.toString());
    } on DioException catch (e) {
      _logError(e);
      _handleDioException(e);
      rethrow;
    }
  }

  /// Unauthenticated portal POST (e.g. forgot password). Sends [siteId] + [lang] only — no auth_key.
  Future<Map<String, dynamic>> postPortalGuestData({
    required String endpoint,
    dynamic data,
    String siteId = Api.portalSiteId,
    String lang = 'Ar',
  }) async {
    final headers = {
      'siteId': siteId,
      'lang': lang,
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    _logRequest('POST-GUEST', endpoint, data, headers);

    try {
      final response = await dio.post(
        endpoint,
        data: data,
        options: Options(
          responseType: ResponseType.json,
          receiveDataWhenStatusError: true,
          validateStatus: (status) => status != null && status < 600,
          headers: headers,
        ),
      );
      _logResponse(response);
      return _responseBodyAsMap(response.data);
    } on DioException catch (e) {
      _logError(e);
      final body = e.response?.data;
      if (body != null) {
        return _responseBodyAsMap(body);
      }
      _handleDioException(e);
      rethrow;
    }
  }

  Map<String, dynamic> _responseBodyAsMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return jsonDecode(data.toString()) as Map<String, dynamic>;
  }

  /// POST (FormData)
  Future<Map<String, dynamic>> postDataForm({
    required String endpoint,
    FormData? query,
    Options? options,
  }) async {
    final token = await _getToken();
    final headers = {"Authorization": "Bearer $token"};
    _logRequest("POST-FORM", endpoint, query?.fields, headers);

    try {
      final response = await dio.post(
        endpoint,
        options:
            options ??
            Options(
              responseType: ResponseType.plain,
              receiveDataWhenStatusError: true,
              headers: headers,
            ),
        data: query,
      );
      _logResponse(response);
      return jsonDecode(response.toString());
    } on DioException catch (e) {
      _logError(e);
      _handleDioException(e);
      rethrow;
    }
  }

  /// POST (x-www-form-urlencoded)
  Future<Map<String, dynamic>> postDataEncode({
    required String endpoint,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    final token = await _getToken();
    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/x-www-form-urlencoded",
    };
    _logRequest("POST-ENCODED", endpoint, query, headers);

    try {
      final response = await dio.post(
        endpoint,
        options:
            options ??
            Options(
              responseType: ResponseType.plain,
              receiveDataWhenStatusError: true,
              headers: headers,
            ),
        data: query,
      );
      _logResponse(response);
      return jsonDecode(response.toString());
    } on DioException catch (e) {
      _logError(e);
      _handleDioException(e);
      rethrow;
    }
  }

  /// Download (with progress)
  Future<File> download({required String url, required String savePath}) async {
    _logRequest("DOWNLOAD", url, null, null);
    try {
      final response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );
      _logResponse(response);

      final file = File(savePath);
      file.writeAsBytesSync(response.data);
      return file;
    } on DioException catch (e) {
      _logError(e);
      rethrow;
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      debugPrint("⬇️ Download progress: ${(received / total * 100).toStringAsFixed(0)}%");
    }
  }

  /// Dio error handling
  void _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        log("⏳ Connection Timeout");
        break;
      case DioExceptionType.sendTimeout:
        log("⏳ Send Timeout");
        break;
      case DioExceptionType.receiveTimeout:
        log("⏳ Receive Timeout");
        break;
      case DioExceptionType.badCertificate:
        log("❌ Bad Certificate");
        break;
      case DioExceptionType.cancel:
        log("⚠️ Request Cancelled");
        break;
      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          log("🌐 No Internet");
        } else {
          log("❓ Unknown Error: $e");
        }
        break;
      case DioExceptionType.badResponse:
        log("❌ Bad Response: ${e.response?.statusCode}");
        break;
      case DioExceptionType.connectionError:
        log("⚠️ Connection Error");
        break;
    }
  }
}
