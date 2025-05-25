import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../models/article_model.dart';
import '../models/paginated_articles_response.dart';

class ArticleRepository {
  final ApiConsumer api;

  ArticleRepository(this.api);

  Future<ArticleModel> createArticles(
      String title,
      String subject,
      File? image,
      ) async {
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
      EndPoints.createArticle,
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );

    return ArticleModel.fromJson(response['data']);
  }



  Future<List<ArticleModel>> fetchArticles() async {
    final response = await api.get(
      EndPoints.getAllArticle,
    );

    if (response['data'] is! List) {
      throw Exception("Unexpected response format");
    }

    final List<dynamic> data = response['data'];
    return data.map((e) => ArticleModel.fromJson(e)).toList();
  }


  Future<PaginatedArticlesResponse> fetchPaginatedArticles({int page = 1}) async {
    final response = await api.get(
      EndPoints.getAllArticle,
      queryParameters: {'page': page},
    );
    print('Paginated Response: $response');

    return PaginatedArticlesResponse.fromJson(response);

  }


  Future<void> deleteArticles(int id) async {
    await api.delete(
      EndPoints.deleteArticle('$id'),
    );
  }

  Future<ArticleModel> updateTip({
    required String id,
    required String title,
    required String subject,
    File? image,
  }) async {
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
      EndPoints.updateArticle(id),
      data: formData,
    );

    return ArticleModel.fromJson(response['data']);
  }
}
