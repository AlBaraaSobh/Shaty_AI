import 'dart:convert';

import 'package:shaty/core/network/api_consumer.dart';

import '../../../../core/network/end_points.dart';
import '../models/doctors_model.dart';

class DoctorRepository {
  final ApiConsumer api;

  DoctorRepository(this.api);


  Future<DoctorsModel> getDoctorProfile() async {
    final response = await api.get(EndPoints.getDoctorProfile);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return DoctorsModel.fromJson(data['doctor']);
    } else {
      throw Exception('فشل في تحميل بيانات الطبيب');
    }
  }

  Future<void> updateBio(String bio) async {
    final response = await api.put(
      EndPoints.updateDoctorBio,
      data: bio
    );
    if (response.statusCode != 200) {
      throw Exception('فشل في تحديث النبذة');
    }
  }

  Future<DoctorsModel> updateProfile({
    required String name,
    required String email,
    required String jopSpecialtyNumber,
    String? bio,
    String? img,
  }) async {
    final body = {
      'name': name,
      'email': email,
      'jop_specialty_number': jopSpecialtyNumber,
      if (bio != null) 'bio': bio,
      if (img != null) 'img': img,
    };

    final response = await api.post(
      EndPoints.updateDoctorProfile,
        data: bio
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return DoctorsModel.fromJson(data['user']);
    } else {
      throw Exception('فشل في تحديث الملف الشخصي');
    }
  }

  Future<List<DoctorsModel>> getFollowers() async {
    final response = await api.get(EndPoints.getDoctorFollowers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data.map((e) => DoctorsModel.fromJson(e)).toList();
    } else {
      throw Exception('فشل في جلب المتابعين');
    }
  }

  Future<Map<String, dynamic>> getDoctorInfo() async {
    final response = await api.get(EndPoints.getDoctorInfo);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('فشل في جلب الإحصائيات');
    }
  }
}
