import 'package:shaty/features/doctor/data/models/article_model.dart';

class ArticleState {
  final bool isLoading;
  final String? failureMessage;
  final String? successMessage;
  final List<ArticleModel> articles;
  final ArticleModel? createdArticle;

  ArticleState(
      { this.isLoading = false,
       this.failureMessage,
       this.successMessage,
       this.articles = const [],
      this.createdArticle
      });

  factory ArticleState.initial() => ArticleState();

  ArticleState copyWith({
    bool? isLoading,
    String? failureMessage,
    String? successMessage,
    List<ArticleModel>? articles,
    ArticleModel? createdArticle,
}){
  return ArticleState(
      isLoading: isLoading ?? this.isLoading,
      failureMessage: failureMessage,
      successMessage: successMessage,
      articles: articles ?? this.articles,
      createdArticle: createdArticle ?? this.createdArticle
  );
}
}
