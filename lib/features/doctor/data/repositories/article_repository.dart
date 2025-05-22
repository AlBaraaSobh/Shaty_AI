import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/utils/helpers/storage_helper.dart';
import '../models/article_model.dart';

class ArticleRepository {
  final ApiConsumer api;

  ArticleRepository(this.api);

  Future<ArticleModel> createArticles(
    String title,
    String subject,
    File? image,
  ) async {
    final token = await StorageHelper.getToken();
    if (token == null) throw Exception("Token is missing");
    final formData = FormData.fromMap({
      'title': title,
      'subject': subject,
      if (image != null)
        'img': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
    });
    final response = await api.post(
      EndPoints.baseUrl + EndPoints.createArticle,
      data: formData,
      options: Options(headers: {
        "Authorization": "Bearer ${token}",
        "Content-Type": "multipart/form-data",
      }),
    );

    print("Response Data*************************: ${response}");
    print('Response type: ${response.runtimeType}');
    print('Response content: $response');

    return ArticleModel.fromJson(response['data']);
  }

  Future<List<ArticleModel>> fetchArticles() async {
    final token = await StorageHelper.getToken();
    if (token == null) throw Exception("Token is missing");
    final response = await api.get(
      EndPoints.baseUrl + EndPoints.getArticle,
      options: Options(headers: {
        "Authorization": "Bearer ${token}",
      }),
    );
    // التأكد من وجود البيانات وتنوعها
    if (response['data'] is! List) {
      throw Exception("Unexpected response format");
    }
    final List<dynamic> data = response['data'];
    return data.map((e) => ArticleModel.fromJson(e)).toList();
  }



  Future<void> deleteArticles(int id) async {
    final token = await StorageHelper.getToken();
    if (token == null) throw Exception("Token is missing");
    final response = await api.delete(
      EndPoints.baseUrl + EndPoints.deleteArticle('${id}'),
      options: Options(headers: {
        "Authorization": "Bearer ${token}",
      }),
    );

  }

  Future<ArticleModel> updateTip({
    required String id,
    required String title,
    required String subject,
    File? image,
  }) async {
    final token = await StorageHelper.getToken();
    if (token == null) throw Exception("Token is missing");

    final formData = FormData.fromMap({
      'title': title,
      'subject': subject,
      if (image != null)
        'img': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
    });
    final response = await api.post(
      EndPoints.baseUrl + EndPoints.updateArticle(id),
      data: formData,
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
    );
    return ArticleModel.fromJson(response['data']);
  }

}
