import 'package:shaty/core/network/end_points.dart';

import '../../../../core/network/api_consumer.dart';


class IsSavedRepository {
  final ApiConsumer api;

  IsSavedRepository(this.api);


  Future<bool> toggleSaveArticle(int articleId) async {
    final response = await api.post(EndPoints.saveArticle(articleId.toString()));
    // الـ API يرجع المفتاح 'saved' = true/false
    return response['saved'] == true;
  }
}