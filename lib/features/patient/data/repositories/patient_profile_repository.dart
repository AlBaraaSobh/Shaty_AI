import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shaty/core/network/api_consumer.dart';
import 'package:shaty/core/network/end_points.dart';

class PatientProfileRepository {
  final ApiConsumer api;

  PatientProfileRepository(this.api);

  Future<void> updateProfile({
    required String name,
    required String email,
    File? image,
  }) async {
    final formData = FormData.fromMap({
      'name': name,
      'email': email,
      if (image != null)
        'img': await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
    });
    await api.post(EndPoints.patientUpdateProfile, data: formData);
  }
}
