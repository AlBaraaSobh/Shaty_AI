import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/article_model.dart';
import 'doctor_profile_state.dart';
import '../data/repositories/doctor_profile_repository.dart';
import 'package:shaty/core/errors/exceptions.dart'; // ⬅️ لإدارة الأخطاء

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  final DoctorProfileRepository repository;

  DoctorProfileCubit(this.repository) : super(DoctorProfileState.initial());

  Future<void> getDoctorProfile({bool forceRefresh = false}) async {
    if (state.doctor != null && !forceRefresh) return;

    emit(state.copyWith(isLoading: true, failureMessage: null));
    try {
      final doctor = await repository.getDoctorProfile();
      emit(state.copyWith(isLoading: false, doctor: doctor));
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }

  Future<void> updateBio(String bio) async {
    emit(state.copyWith(isLoading: true, failureMessage: null));
    try {
      await repository.updateBio(bio);
      await getDoctorProfile(forceRefresh: true);
      emit(state.copyWith(
        isLoading: false,
        successMessage: 'تم تحديث النبذة بنجاح',
      ));
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String jopSpecialtyNumber,
    String? bio,
    String? img,
  }) async {
    emit(state.copyWith(isLoading: true, failureMessage: null));
    try {
      final updatedDoctor = await repository.updateProfile(
        name: name,
        email: email,
        jopSpecialtyNumber: jopSpecialtyNumber,
        bio: bio,
        img: img,
      );
      emit(state.copyWith(
        isLoading: false,
        doctor: updatedDoctor,
        successMessage: 'تم تحديث الملف الشخصي بنجاح',
      ));
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }

  Future<void> getDoctorInfo({bool forceRefresh = false}) async {
    if (state.info != null && !forceRefresh) return;

    emit(state.copyWith(isLoading: true, failureMessage: null));
    try {
      final info = await repository.getDoctorInfo();
      emit(state.copyWith(isLoading: false, info: info));
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }

  Future<void> getFollowers() async {
    emit(state.copyWith(isLoading: true, failureMessage: null));
    try {
      final followers = await repository.getFollowers();
      emit(state.copyWith(isLoading: false, followers: followers));
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }

  Future<void> getDoctorArticles({bool forceRefresh = false}) async {
    if (state.articles.isNotEmpty && !forceRefresh) return;

    emit(state.copyWith(isLoading: true, failureMessage: null));
    try {
      final articles = await repository.getDoctorArticles();
      emit(state.copyWith(isLoading: false, articles: articles));
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }

  Future<void> deleteArticle(int id) async {
    emit(state.copyWith(isLoading: true, failureMessage: null));
    try {
      await repository.deleteArticle(id);
      final updatedArticles = state.articles.where((a) => a.id != id).toList();
      emit(state.copyWith(
        isLoading: false,
        articles: updatedArticles,
        deletedArticleId: id,
        successMessage: 'تم حذف المقال بنجاح',
      ));
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }

  // ✅ لتحديث اللايك أو التعليق أو الحفظ من الصفحة الشخصية
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
    emit(DoctorProfileState.initial());
  }
}

// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/errors/exceptions.dart';
// import '../data/models/article_model.dart';
// import 'doctor_profile_state.dart';
// import '../data/repositories/doctor_profile_repository.dart';
//
// class DoctorProfileCubit extends Cubit<DoctorProfileState> {
//   final DoctorProfileRepository repository;
//
//   DoctorProfileCubit(this.repository) : super(DoctorProfileState.initial());
//
//   Future<void> getDoctorProfile({bool forceRefresh = false}) async {
//     if (state.doctor != null && !forceRefresh) return;
//
//     emit(state.copyWith(isLoading: true, failureMessage: null));
//     try {
//       final doctor = await repository.getDoctorProfile();
//       emit(state.copyWith(isLoading: false, doctor: doctor));
//     } catch (e) {
//       emit(state.copyWith(isLoading: false, failureMessage: e.toString()));
//     }
//   }
//
//
//   Future<void> updateBio(String bio) async {
//     emit(state.copyWith(isLoading: true, failureMessage: null));
//     try {
//       await repository.updateBio(bio);
//       await getDoctorProfile();
//       emit(state.copyWith(isLoading: false, successMessage: 'تم تحديث النبذة بنجاح'));
//     } catch (e) {
//       emit(state.copyWith(isLoading: false, failureMessage: e.toString()));
//     }
//   }
//
//   Future<void> updateProfile({
//     required String name,
//     required String email,
//     required String jopSpecialtyNumber,
//     String? bio,
//     String? img,
//   }) async {
//     emit(state.copyWith(isLoading: true, failureMessage: null));
//     try {
//       final updatedDoctor = await repository.updateProfile(
//         name: name,
//         email: email,
//         jopSpecialtyNumber: jopSpecialtyNumber,
//         bio: bio,
//         img: img,
//       );
//       emit(state.copyWith(
//         isLoading: false,
//         doctor: updatedDoctor,
//         successMessage: 'تم تحديث الملف الشخصي بنجاح',
//       ));
//     } catch (e) {
//       emit(state.copyWith(isLoading: false, failureMessage: e.toString()));
//     }
//   }
//
//   Future<void> getDoctorInfo() async {
//     if (state.doctor != null) return; // ✅ لا تعيد الطلب إذا البيانات موجودة
//   //  if (state.info != null && !forceRefresh) return;
//
//     emit(state.copyWith(isLoading: true, failureMessage: null));
//     try {
//       final info = await repository.getDoctorInfo();
//       emit(state.copyWith(isLoading: false, info: info));
//     } catch (e) {
//       final message = ErrorHandler.handle(e);
//       emit(state.copyWith(isLoading: false, failureMessage: message));
//     }
//   }
//
//   Future<void> getFollowers() async {
//     emit(state.copyWith(isLoading: true, failureMessage: null));
//     try {
//       final followers = await repository.getFollowers();
//       emit(state.copyWith(isLoading: false, followers: followers));
//     } catch (e) {
//       final message = ErrorHandler.handle(e);
//       emit(state.copyWith(isLoading: false, failureMessage: message));
//     }
//   }
//
//   Future<void> getDoctorArticles({bool forceRefresh = false}) async {
//     emit(state.copyWith(isLoading: true, failureMessage: null));
//     try {
//       final articles = await repository.getDoctorArticles();
//       emit(state.copyWith(isLoading: false, articles: articles));
//     } catch (e) {
//       final message = ErrorHandler.handle(e);
//       emit(state.copyWith(isLoading: false, failureMessage: message));
//     }
//   }
//
//   Future<void> deleteArticle(int id) async {
//     emit(state.copyWith(isLoading: true, failureMessage: null));
//     try {
//       await repository.deleteArticle(id);
//       final updatedArticles = state.articles.where((a) => a.id != id).toList();
//       emit(state.copyWith(
//         isLoading: false,
//         articles: updatedArticles,
//         deletedArticleId: id,
//         successMessage: 'تم حذف المقال بنجاح',
//       ));
//     } catch (e) {
//       final message = ErrorHandler.handle(e);
//       emit(state.copyWith(isLoading: false, failureMessage: message));
//     }
//   }
// // لتحديث اللايك و التعليق و الحفظ في صفحة البروفايل الخاصةة في الطبيب
//   void updateSingleArticle(ArticleModel updatedArticle) {
//     final updatedArticles = state.articles.map((article) {
//       return article.id == updatedArticle.id ? updatedArticle : article;
//     }).toList();
//
//     emit(state.copyWith(articles: updatedArticles));
//   }
//   void clearMessages() {
//     emit(state.copyWith(successMessage: null, failureMessage: null));
//   }
//   void clear() {
//     emit(DoctorProfileState.initial());
//   }
//
// }
