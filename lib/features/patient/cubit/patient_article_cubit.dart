import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/errors/exceptions.dart';
import 'package:shaty/features/doctor/data/models/article_model.dart';
import 'package:shaty/features/doctor/data/repositories/article_repository.dart';
import 'package:shaty/features/doctor/cubit/article_state.dart';

class PatientArticleCubit extends Cubit<ArticleState> {
  final ArticleRepository repository;

  PatientArticleCubit(this.repository) : super(ArticleState.initial());

  Future<void> getPaginatedArticles(int page) async {
    emit(state.copyWith(
      isLoading: true,
      successMessage: null,
      failureMessage: null,
    ));
    try {
      final paginatedResponse = await repository.fetchPaginatedArticles(page: page);
      final articlesList = paginatedResponse.data;

      if (articlesList.isEmpty) {
        if (page == 1) {
          emit(state.copyWith(
            isLoading: false,
            articles: [],
            successMessage: 'لا توجد مقالات حالياً',
            lastPage: paginatedResponse.lastPage,
          ));
        } else {
          emit(state.copyWith(
            isLoading: false,
            articles: state.articles,
            lastPage: paginatedResponse.lastPage,
            successMessage: 'انتهت المقالات',
          ));
        }
        return;
      }

      List<ArticleModel> updatedArticles;
      if (page == 1) {
        updatedArticles = articlesList;
      } else {
        updatedArticles = [...state.articles, ...articlesList];
      }

      emit(state.copyWith(
        isLoading: false,
        articles: updatedArticles,
        lastPage: paginatedResponse.lastPage,
      ));
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }

  Future<void> likeArticle(int articleId) async {
    final articleExists = state.articles.any((article) => article.id == articleId);
    if (!articleExists) {
      emit(state.copyWith(failureMessage: 'المقال غير موجود'));
      return;
    }

    try {
      final isLikedNow = await repository.likeArticle(articleId);

      final updatedArticles = state.articles.map((article) {
        if (article.id == articleId) {
          final updatedLikesCount = isLikedNow
              ? article.articleInfo.numLikes + 1
              : (article.articleInfo.numLikes > 0
              ? article.articleInfo.numLikes - 1
              : 0);

          final updatedArticleInfo = article.articleInfo.copyWith(
            isLiked: isLikedNow,
            numLikes: updatedLikesCount,
          );

          return article.copyWith(articleInfo: updatedArticleInfo);
        }
        return article;
      }).toList();

      emit(state.copyWith(articles: updatedArticles));
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(failureMessage: message));
    }
  }

  void toggleLocalSaveStatus(int articleId) {
    final updatedArticles = state.articles.map((article) {
      if (article.id == articleId) {
        final updatedInfo = article.articleInfo.copyWith(
          isSaved: !article.articleInfo.isSaved,
        );
        return article.copyWith(articleInfo: updatedInfo);
      }
      return article;
    }).toList();

    emit(state.copyWith(articles: updatedArticles));
  }
  void incrementCommentCount(int articleId) {
    final updatedArticles = state.articles.map((article) {
      if (article.id == articleId) {
        final updatedInfo = article.articleInfo.copyWith(
          numComments: article.articleInfo.numComments + 1,
        );
        return article.copyWith(articleInfo: updatedInfo);
      }
      return article;
    }).toList();

    emit(state.copyWith(articles: updatedArticles));
  }

  void updateSingleArticle(ArticleModel updatedArticle) {
    final updatedArticles = state.articles.map((article) {
      return article.id == updatedArticle.id ? updatedArticle : article;
    }).toList();

    emit(state.copyWith(articles: updatedArticles));
  }


  void clearMessages() {
    emit(state.copyWith(successMessage: null, failureMessage: null));
  }

  void clear() {
    emit(ArticleState.initial());
  }
}
