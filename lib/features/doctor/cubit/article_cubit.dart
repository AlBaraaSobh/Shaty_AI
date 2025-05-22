import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/doctor/cubit/article_state.dart';
import 'package:shaty/features/doctor/data/repositories/article_repository.dart';

import '../../../core/errors/exceptions.dart';
import '../data/models/article_model.dart';

class ArticleCubit extends Cubit<ArticleState>{
  final ArticleRepository articleRepository;
  ArticleCubit(this.articleRepository) : super(ArticleState.initial());

  Future<void> createArticle(
      {required String title,
        required String subject ,
        File ?img }) async {

    emit(state.copyWith(
        isLoading: true, failureMessage: null, successMessage: null));
    try {
      // إنشاء المقال من خلال الريبو
      final ArticleModel newArticle = await articleRepository.createArticles(title, subject,img);
    //  await getArticles();
      emit(state.copyWith(
          isLoading: false, successMessage: 'تمت إضافة المنشور بنجاح',articles: [newArticle, ...state.articles]));//خلي أول عنصر هو المقال الجديد، ثم أضف باقي المقالات تحته
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }


  Future<void> getArticles() async {
    emit(state.copyWith(
        isLoading: true, failureMessage: null, successMessage: null));

    try {
      final articlesList  = await articleRepository.fetchArticles();
      if (articlesList .isEmpty) {
        emit(state.copyWith(
            isLoading: false, articles: [], successMessage: 'لا توجد مقالات حالياً'));
      } else {
        emit(state.copyWith(
          isLoading: false,
          articles: articlesList ,
        ));
      }
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }

  void clearMessages() {
    emit(state.copyWith(successMessage: null, failureMessage: null));
  }

}


