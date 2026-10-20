import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Prints URL, request and response of every Dio call to the console (debug builds only).
class ApiLogInterceptor extends Interceptor {
  static const _encoder = JsonEncoder.withIndent('  ');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['_startTime'] = DateTime.now().millisecondsSinceEpoch;
    _print([
      '┌── ➡️ REQUEST ────────────────────────────────',
      '│ ${options.method} ${options.uri}',
      '│ Headers: ${_format(options.headers)}',
      if (options.data != null) '│ Body: ${_format(options.data)}',
      '└──────────────────────────────────────────────',
    ]);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _print([
      '┌── ✅ RESPONSE ${response.statusCode} (${_elapsed(response.requestOptions)}) ──────────',
      '│ ${response.requestOptions.method} ${response.requestOptions.uri}',
      '│ Body: ${_format(response.data)}',
      '└──────────────────────────────────────────────',
    ]);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _print([
      '┌── ❌ ERROR ${err.response?.statusCode ?? ''} (${_elapsed(err.requestOptions)}) ──────────',
      '│ ${err.requestOptions.method} ${err.requestOptions.uri}',
      '│ Type: ${err.type}',
      if (err.message != null) '│ Message: ${err.message}',
      if (err.response?.data != null) '│ Body: ${_format(err.response?.data)}',
      '└──────────────────────────────────────────────',
    ]);
    handler.next(err);
  }

  String _elapsed(RequestOptions options) {
    final start = options.extra['_startTime'];
    if (start is! int) return '?';
    return '${DateTime.now().millisecondsSinceEpoch - start}ms';
  }

  String _format(dynamic data) {
    if (data is FormData) {
      final fields = {for (final f in data.fields) f.key: f.value};
      final files = data.files.map((f) => '${f.key}: ${f.value.filename}').toList();
      return _format({'fields': fields, 'files': files});
    }
    if (data is List<int>) return '<${data.length} bytes>';
    if (data is Map || data is List) {
      try {
        return _encoder.convert(data);
      } catch (_) {
        return data.toString();
      }
    }
    return data.toString();
  }

  // Print line by line so logcat doesn't truncate long bodies.
  void _print(List<String> lines) {
    if (!kDebugMode) return;
    for (final line in lines.join('\n').split('\n')) {
      debugPrint(line);
    }
  }
}
