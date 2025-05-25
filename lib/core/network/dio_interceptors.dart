import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../errors/exceptions.dart';
import '../errors/server_exception.dart';
import '../utils/helpers/storage_helper.dart';

class DioInterceptors extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await StorageHelper.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    _logRequest(options);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logResponse(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final message  = ErrorHandler.handle(err);
    _showErrorMessage(message);
    handler.next(err);
  }

  void _logRequest(RequestOptions options) {
    debugPrint("📤 REQUEST [${options.method}] => PATH: ${options.uri}");
    debugPrint("Headers: ${options.headers}");
    debugPrint("Data: ${options.data}");
  }

  void _logResponse(Response response) {
    debugPrint("✅ RESPONSE [${response.statusCode}] => DATA: ${response.data}");
  }

  void _showErrorMessage(String message) {
    debugPrint('❌ Dio Error Message: $message');
    // يمكنك لاحقاً تفعيل التوست هنا لو كان عندك context عام للتطبيق
  }
}
