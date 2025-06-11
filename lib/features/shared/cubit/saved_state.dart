import '../../doctor/data/models/article_model.dart';

class SavedState {
  final bool isLoading;
  final bool isLoadingMore;//لتمنع تحميل نفس الصفحة أكثر من مرة
  final String? failureMessage;
  final String? successMessage;
  final List<ArticleModel> articles;
  final int currentPage;
  final bool hasMore;//هل فيه صفحات أكثر نقدر نجيبها

  SavedState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.failureMessage,
    this.successMessage,
    this.articles = const [],
    this.currentPage = 1,
    this.hasMore = true,
  });

  factory SavedState.initial() => SavedState();

  SavedState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    String? failureMessage,
    String? successMessage,
    List<ArticleModel>? articles,
    int? currentPage,
    bool? hasMore,
  }) {
    return SavedState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      failureMessage: failureMessage,
      successMessage: successMessage,
      articles: articles ?? this.articles,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
