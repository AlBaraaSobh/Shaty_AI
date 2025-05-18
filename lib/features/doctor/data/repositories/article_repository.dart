import 'package:dio/dio.dart';

import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/utils/helpers/storage_helper.dart';
import '../models/article_model.dart';

class ArticleRepository {
  final ApiConsumer api;
  ArticleRepository(this.api);


  Future<ArticleModel> createArticle(
     String title,
     String subject,
     String? image,
  ) async {
    final token = await StorageHelper.getToken();
    if (token == null) throw Exception("Token is missing");
    final formData = FormData.fromMap({
      'title': title,
      'subject': subject,
      if (image != null)
        'img': await MultipartFile.fromFile(image),
    });
    final response = await api.post(
      EndPoints.baseUrl + EndPoints.createPost,
      data: formData,
      options: Options(headers: {
        "Authorization": "Bearer ${token}",
        "Content-Type": "multipart/form-data",
      }),
    );
    return ArticleModel.fromJson(response.data['data']);

  }
}