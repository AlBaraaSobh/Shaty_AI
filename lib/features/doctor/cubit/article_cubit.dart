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
        String ?img }) async {

    emit(state.copyWith(
        isLoading: true, failureMessage: null, successMessage: null));
    try {
      // إنشاء المقال من خلال الريبو
      final ArticleModel newArticle = await articleRepository.createArticle(title, subject, img);
      emit(state.copyWith(
          isLoading: false, successMessage: 'تمت إضافة المنشور بنجاح',articles: [newArticle, ...state.articles]));//خلي أول عنصر هو المقال الجديد، ثم أضف باقي المقالات تحته
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }
}



// class ArticleCubit extends Cubit<ArticleState> {
//   final ArticleRepository _articleRepository;
//
//   ArticleCubit(this._articleRepository) : super(ArticleState.initial());
//
//   Future<void> createArticle({
//     required String title,
//     required String subject,
//     File? img,
//   }) async {
//     emit(state.copyWith(
//       isLoading: true,
//       failureMessage: null,
//       successMessage: null,
//     ));
//
//     try {
//       final ArticleModel newArticle =
//       await _articleRepository.createArticle(title, subject, img);
//
//       emit(state.copyWith(
//         isLoading: false,
//         successMessage: 'تمت إضافة المقال بنجاح',
//         createdArticle: newArticle,
//         articles: [newArticle, ...state.articles], // لإضافة المقال الجديد للقائمة
//       ));
//     } catch (e) {
//       final message = ErrorHandler.handle(e);
//       emit(state.copyWith(
//         isLoading: false,
//         failureMessage: message,
//       ));
//     }
//   }
// }
