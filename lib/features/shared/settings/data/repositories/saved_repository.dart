import 'package:shaty/core/network/end_points.dart';

import '../../../../../core/network/api_consumer.dart';
import '../../../../doctor/data/models/paginated_articles_response.dart';


class SavedRepository {
  final ApiConsumer api;
  SavedRepository(this.api);



  Future<PaginatedArticlesResponse> getSavedArticles({int page = 1}) async {
      final response = await api.get(
        EndPoints.articleSaved,
        queryParameters: {'page': page},
      );

      return PaginatedArticlesResponse.fromJson(response);


  }
}

