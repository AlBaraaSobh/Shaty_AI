import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/doctor/cubit/article_state.dart';
import 'package:shaty/features/doctor/data/repositories/article_repository.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/helpers/helpers.dart';
import '../data/models/article_model.dart';

class ArticleCubit extends Cubit<ArticleState>{
  final ArticleRepository articleRepository;
  ArticleCubit(this.articleRepository) : super(ArticleState.initial());

  Future<void> createArticle(
      {required String title,
        required String subject ,
        File ?img }) async {

    emit(state.copyWith(isLoading: true, failureMessage: null, successMessage: null));
    try {
      final ArticleModel newArticle = await articleRepository.createArticles(title, subject,img);
    //  await getArticles();
      emit(state.copyWith(
          isLoading: false, successMessage: 'تمت إضافة المنشور بنجاح',articles: [newArticle, ...state.articles]));//خلي أول عنصر هو المقال الجديد، ثم أضف باقي المقالات تحته
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }


  Future<void> getPaginatedArticles(int page) async {
    emit(state.copyWith(
        isLoading: true, failureMessage: null, successMessage: null));
    try {
      final paginatedResponse = await articleRepository.fetchPaginatedArticles(page: page);
      final articlesList = paginatedResponse.data;
      print('articlesList***************** ${articlesList}');
      for (var article in articlesList) {
        print('📄 مقال: id=${article.id}, isLiked=${article.articleInfo.isLiked}, likes=${article.articleInfo.numLikes}');
      }

      if (articlesList.isEmpty) {
        // الصفحة الأولى = لا توجد مقالات حالياً
        if (page == 1) {
          emit(state.copyWith(
            isLoading: false,
            successMessage: 'لا توجد مقالات حالياً',
            articles: [],
            lastPage: paginatedResponse.lastPage,
          ));
        } else {
          // صفحات لاحقة = انتهت المقالات
          emit(state.copyWith(
            isLoading: false,
            articles: state.articles, // لا تغير القائمة
            lastPage: paginatedResponse.lastPage,
            successMessage: 'انتهت المقالات'
          ));
        }
        return;
      } else {
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
      }
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }

  Future<void> likeArticle(int articleId) async {
    print('🔄 بدء عملية الإعجاب للمقال: $articleId');

    final currentArticle = state.articles.firstWhere((article) => article.id == articleId);
    print('📊 حالة المقال الحالية - مُعجب: ${currentArticle.articleInfo.isLiked}, عدد الإعجابات: ${currentArticle.articleInfo.numLikes}');

    try {
      final isLikedNow = await articleRepository.likeArticle(articleId);
      print('✅ رد الخادم - مُعجب الآن: $isLikedNow');

      final updatedArticles = state.articles.map((article) {
        if (article.id == articleId) {
          final currentLikesCount = article.articleInfo.numLikes;
          final updatedLikesCount = isLikedNow
              ? currentLikesCount + 1
              : (currentLikesCount > 0 ? currentLikesCount - 1 : 0);

          // تحديث articleInfo فقط
          final updatedArticleInfo = article.articleInfo.copyWith(
            isLiked: isLikedNow,
            numLikes: updatedLikesCount,
          );

          return article.copyWith(articleInfo: updatedArticleInfo);
        }
        return article;
      }).toList();

      emit(state.copyWith(articles: updatedArticles));
      print('✅ تم تحديث الحالة بنجاح');

    } catch (e) {
      print('⚠️ حدث خطأ أثناء تحديث الحالة: $e');
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(failureMessage: message));
    }
  }

  void clearMessages() {
    emit(state.copyWith(successMessage: null, failureMessage: null));
  }


}


