import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/utils/helpers/storage_helper.dart';
import '../models/article_model.dart';
import '../models/comment_model.dart';
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
    final token = await StorageHelper.getToken();
    if (token == null || token.isEmpty) {
      print("🚨 مفيش توكن محفوظ!");
      throw Exception("Unauthorized: No token found");
    }

    print("🔐 Using token: $token");

    // إرسال الطلب مع إجبار Dio على إرجاع النص الخام
    final responseString = await api.get(
      EndPoints.getAllArticle,
      queryParameters: {'page': page},
      options: Options(
        responseType: ResponseType.plain, // مهم جدًا هنا
      ),
    );

    print('Raw Response String: $responseString');

    // تحليل النص يدويًا إلى JSON
    final Map<String, dynamic> responseJson = jsonDecode(responseString);

    print('Parsed JSON keys: ${responseJson.keys}');

    // تحويل JSON إلى موديل pagination الخاص بك
    return PaginatedArticlesResponse.fromJson(responseJson);
  }





  Future<void> deleteArticles(int id) async {
    final response = await api.delete(
      EndPoints.deleteArticle('$id'),
    );

    if (response.toString().toLowerCase().contains('deleted') == false) {
      throw Exception('فشل في الحذف');
    }
  }

  Future<void> updateArticle({
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

    if (response is String && response.toLowerCase().contains('updated')) {
      return; // ✅ نجحنا، فقط رجعنا بدون خطأ
    }

    throw Exception('فشل في التعديل');
  }



  Future<bool> likeArticle(int articleId) async {
    try {
      final response = await api.post(EndPoints.likeArticle(articleId.toString()));
      if (response is Map<String, dynamic> && response.containsKey('like')) {
        return response['like'] == true;
      }
      return false;
    } catch (e) {
      print('❌ خطأ أثناء عمل لايك: $e');
      rethrow; // حتى يتم التقاطه بشكل طبيعي في cubit
    }
  }

  Future<void> saveArticle(int articleId) async {
    final response = await api.post(EndPoints.saveArticle(articleId.toString()));
    if (response['saved'] != true) {
      throw Exception('Failed to save article');
    }
  }


}

// Future<ArticleModel> updateArticle({
//   required String id,
//   required String title,
//   required String subject,
//   File? image,
// }) async {
//   final formData = FormData.fromMap({
//     'title': title,
//     'subject': subject,
//     if (image != null)
//       'img': await MultipartFile.fromFile(
//         image.path,
//         filename: image.path.split('/').last,
//       ),
//   });
//   final response = await api.post(
//     EndPoints.updateArticle(id),
//     data: formData,
//   );
//
//   if (response is String) {
//     // فقط رسالة نجاح - لا ترجع ArticleModel
//     return Future.error('تم التعديل بنجاح ولكن لم يتم إرجاع بيانات المقال');
//   } else if (response is Map<String, dynamic> && response.containsKey('data')) {
//     return ArticleModel.fromJson(response['data']);
//   } else {
//     throw Exception('استجابة غير متوقعة من الخادم');
//   }
// }
// Future<PaginatedArticlesResponse> fetchPaginatedArticles({int page = 1}) async {
//   final token = await StorageHelper.getToken();
//   if (token == null || token.isEmpty) {
//     print("🚨 مفيش توكن محفوظ!");
//     throw Exception("Unauthorized: No token found");
//   }
//
//   print("🔐 Using token: $token");
//   final response = await api.get(
//     EndPoints.getAllArticle,
//     queryParameters: {'page': page},
//   );
//   print('Paginated Response: $response');
//   print('Response keys: ${response.keys}');
//
//
//   return PaginatedArticlesResponse.fromJson(response);
//
// }
