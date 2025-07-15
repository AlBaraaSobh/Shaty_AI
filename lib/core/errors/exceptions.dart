import 'dart:io';
import 'package:dio/dio.dart';

import 'error_model.dart';

class ErrorHandler {
  static String handle(dynamic error) {
    if (error is DioException) {
      // Dio-specific errors
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'انتهت مهلة الاتصال بالخادم.';
        case DioExceptionType.sendTimeout:
          return 'استغرقت عملية الإرسال وقتًا طويلاً.';
        case DioExceptionType.receiveTimeout:
          return 'استغرقت عملية الاستلام وقتًا طويلاً.';
        case DioExceptionType.badResponse:
          return _handleResponseError(error);
        case DioExceptionType.cancel:
          return 'تم إلغاء الطلب.';
        case DioExceptionType.unknown:
        default:
          if (error.error is SocketException) {
            return 'لا يوجد اتصال بالإنترنت.';
          }
          return 'حدث خطأ غير متوقع. يرجى المحاولة لاحقًا.';
      }
    } else if (error is SocketException) {
      return 'تعذر الاتصال بالإنترنت.';
    } else if (error is FormatException) {
      return 'خطأ في تنسيق البيانات.';
    } else {
      return 'حدث خطأ غير متوقع.';
    }
  }


  static String _handleResponseError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      final errorModel = ErrorModel.fromJson(data);

      if (statusCode == 422) {
        final errorMessage = errorModel.firstErrorMessage;

        if (errorMessage.toLowerCase().contains('credentials')) {
          return 'بيانات الدخول غير صحيحة';
        }

        return errorMessage;
      }


      return errorModel.message ?? 'حدث خطأ أثناء الاتصال بالخادم.';
    }
    print("Status code: $statusCode");
    print("Response data: $data");

    // fallback
    return 'حدث خطأ أثناء الاتصال بالخادم.';
  }


}
