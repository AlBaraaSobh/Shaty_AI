
import 'package:dio/dio.dart';
import 'package:shaty/core/network/api_consumer.dart';
import 'package:shaty/core/network/end_points.dart';
import '../models/doctor_stats_model.dart';
import '../models/doctors_model.dart';
import '../models/article_model.dart';

class DoctorProfileRepository {
  final ApiConsumer api;

  DoctorProfileRepository(this.api);

  Future<DoctorsModel> getDoctorProfile() async {
    final response = await api.get(EndPoints.getDoctorProfile);
    return DoctorsModel.fromJson(response['doctor']);
  }

  Future<void> updateBio(String bio) async {
    await api.put(EndPoints.updateDoctorBio, data: {'bio': bio});
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

    final response = await api.post(EndPoints.updateDoctorProfile, data: body);
    return DoctorsModel.fromJson(response['user']);
  }

  // Future<Map<String, dynamic>> getDoctorInfo() async {
  //   return await api.get(EndPoints.getDoctorInfo);
  // }

  Future<DoctorStatsModel> getDoctorInfo() async {
    final data = await api.get(EndPoints.getDoctorInfo);
    return DoctorStatsModel.fromJson(data);
  }

  //
  // Future<List<DoctorsModel>> getFollowers() async {
  //   final response = await api.get(EndPoints.getDoctorFollowers);
  //   print('📦 Response followers: $response');
  //
  //   final data = response['data'] as List;
  //   return data.map((e) => DoctorsModel.fromJson(e)).toList();
  // }



  // Future<List<DoctorsModel>> getFollowers() async {
  //   final data = await api.get(EndPoints.getDoctorFollowers);
  //   return (data as List).map((e) => DoctorsModel.fromJson(e)).toList();
  // }

  Future<List<ArticleModel>> getDoctorArticles() async {
    final data = await api.get(EndPoints.getArticle);
    return (data['data'] as List).map((e) => ArticleModel.fromJson(e)).toList();
  }

  Future<void> deleteArticle(int id) async {
    await api.delete('${EndPoints.deleteArticle}/$id');
  }
  Future<String> uploadProfileImage(String filePath) async {
    final formData = FormData.fromMap({
      'img': await MultipartFile.fromFile(filePath, filename: 'profile.jpg'),
    });

    final response = await api.post(
      EndPoints.updateDoctorImage,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    return response['image_url'];
  }

}
