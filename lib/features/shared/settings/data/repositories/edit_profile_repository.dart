  import 'package:dio/dio.dart';

  import '../../../../../core/errors/server_exception.dart';
  import '../../../../../core/network/api_consumer.dart';
  import '../../../../../core/network/end_points.dart';

  class EditProfileRepository {
    final ApiConsumer api;

    EditProfileRepository(this.api);

    Future<String> updateProfile({
      required String name,
      required String email,
      required String bio,
      required String specialtyNumber,
      required String? imagePath,
    }) async {
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'bio': bio,
        'jop_specialty_number': specialtyNumber,
        if (imagePath != null)
          'img': await MultipartFile.fromFile(imagePath, filename: imagePath.split('/').last),
      });

      final response = await api.post(EndPoints.editDoctorProfile, data: formData);

      if (response['message'] != null) {
        return response['message'];
      } else {
        throw ServerException('فشل تحديث الملف الشخصي');
      }
    }
  }