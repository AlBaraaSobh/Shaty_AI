import 'article_model.dart';

class PaginatedArticlesResponse {
  final List<ArticleModel> data;
  final int currentPage;
  final int lastPage;
  final String? nextPageUrl;

  PaginatedArticlesResponse({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    this.nextPageUrl,
  });

  factory PaginatedArticlesResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedArticlesResponse(
      data: (json['data'] as List)
          .map((item) => ArticleModel.fromJson(item))
          .toList(),
      currentPage: json['meta']['current_page'],
      lastPage: json['meta']['last_page'],
      nextPageUrl: json['links']['next'],
    );
  }
}
