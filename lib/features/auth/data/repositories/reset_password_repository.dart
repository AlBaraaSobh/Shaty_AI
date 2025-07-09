import 'package:dio/dio.dart';
import 'package:shaty/core/network/api_consumer.dart';
import 'package:shaty/core/network/end_points.dart';
import 'package:shaty/core/errors/exceptions.dart';

class ResetPasswordRepository {
  final ApiConsumer api;
  ResetPasswordRepository(this.api);

  Future<void> sendResetCode(String email) async {
    try {
      await api.post(EndPoints.forgetPassword, data: {'email': email});
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<String> checkResetCode({required String email, required String code}) async {
    final response = await api.post('/check-code', data: {
      'email': email,
      'reset_code': code,
    });
    return response['token']; // يجب أن يرجع التوكن من السيرفر
  }

  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String token,
  }) async {
    await api.post(
      EndPoints.resetPassword,
      data: {
        'email': email,
        'password': newPassword,
        'password_confirmation': newPassword, // ✅ مهم جدًا
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

}
