
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/end_points.dart';
class LoginRepository {
  final ApiConsumer api;
  LoginRepository(this.api);

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(
        EndPoints.login,
        data: {
          'email': email.trim(),
          'password': password.trim(),
        },
      );
      return response;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}