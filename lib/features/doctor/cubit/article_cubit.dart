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
    print('📊 حالة المقال الحالية - مُعجب: ${currentArticle.isLiked}, عدد الإعجابات: ${currentArticle.likesCount}');

    try {
      final isLikedNow = await articleRepository.likeArticle(articleId);
      print('✅ رد الخادم - مُعجب الآن: $isLikedNow');

      final updatedArticles = state.articles.map((article) {
        if (article.id == articleId) {
          final updatedLikesCount = isLikedNow ? article.likesCount + 1 : article.likesCount - 1;
          print('📈 عدد الإعجابات الجديد: $updatedLikesCount');
          return article.copyWith(
            isLiked: isLikedNow,
            likesCount: updatedLikesCount,
          );
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
  // Future<void> likeArticle(int articleId) async {
  //   try {
  //     // تحديث مباشر سريع
  //     final updatedArticles = state.articles.map((article) {
  //       if (article.id == articleId) {
  //         final isLikedNow = !article.isLiked;
  //         final updatedLikesCount = isLikedNow ? article.likesCount + 1 : article.likesCount - 1;
  //         return article.copyWith(
  //           isLiked: isLikedNow,
  //           likesCount: updatedLikesCount,
  //         );
  //       }
  //       return article;
  //     }).toList();
  //
  //     emit(state.copyWith(articles: updatedArticles));
  //
  //     // إرسال اللايك الحقيقي للسيرفر
  //     await articleRepository.likeArticle(articleId);
  //
  //   } catch (e) {
  //     final message = ErrorHandler.handle(e);
  //     emit(state.copyWith(failureMessage: message));
  //   }
  // }


  // Future<void> likeArticle(int articleId) async {
  //   try {
  //     await articleRepository.likeArticle(articleId);
  //     final updatedArticles = state.articles.map((article) {
  //       if (article.id == articleId) {
  //         final isLikedNow = !article.isLiked;
  //         final updatedLikesCount = isLikedNow ? article.likesCount + 1 : article.likesCount - 1;
  //         return ArticleModel(
  //           id: article.id,
  //           title: article.title,
  //           subject: article.subject,
  //           img: article.img,
  //           doctor: article.doctor,
  //           articleInfo: article.articleInfo,
  //           createdAt: article.createdAt,
  //           isLiked: isLikedNow,
  //           isBookmarked: article.isBookmarked,
  //           likesCount: updatedLikesCount,
  //         );
  //       }
  //       return article;
  //     }).toList();
  //
  //     emit(state.copyWith(articles: updatedArticles));
  //   } catch (e) {
  //     final message = ErrorHandler.handle(e);
  //     emit(state.copyWith(failureMessage: message));
  //   }
  // }


  void clearMessages() {
    emit(state.copyWith(successMessage: null, failureMessage: null));
  }

// Future<void> getArticles() async {
//   emit(state.copyWith(
//       isLoading: true, failureMessage: null, successMessage: null));
//
//   try {
//     final articlesList  = await articleRepository.fetchArticles();
//     if (articlesList .isEmpty) {
//       emit(state.copyWith(
//           isLoading: false, articles: [], successMessage: 'لا توجد مقالات حالياً'));
//     } else {
//       emit(state.copyWith(
//         isLoading: false,
//         articles: articlesList ,
//       ));
//     }
//   } catch (e) {
//     final message = ErrorHandler.handle(e);
//     emit(state.copyWith(isLoading: false, failureMessage: message));
//   }
// }
}


