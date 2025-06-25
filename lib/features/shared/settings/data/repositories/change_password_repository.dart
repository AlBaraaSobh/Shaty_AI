import 'package:shaty/core/network/end_points.dart';

import '../../../../../core/errors/server_exception.dart';
import '../../../../../core/network/api_consumer.dart';

class ChangePasswordRepository {
  final ApiConsumer api;
  ChangePasswordRepository(this.api);

  Future<String> changePassword({
    required String lastPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await api.post(
      EndPoints.changePassword,
      data: {
        "last_password": lastPassword,
        "password": newPassword,
        "password_confirmation": confirmPassword,
      },

    );
    print('🔁 Response from API: $response');
    if (response != null && response['message'] != null) {
      return response['message'];
    } else {
      throw ServerException('حدث خطأ أثناء تغيير كلمة المرور');
    }
  }



}