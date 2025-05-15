import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/errors/exceptions.dart';
import 'package:shaty/features/doctor/cubit/tips_state.dart';
import 'package:shaty/features/doctor/data/repositories/tips_repository.dart';

import '../data/models/tips_model.dart';


class TipsCubit extends Cubit<TipsState> {
  final TipsRepository tipsRepository;

  TipsCubit(this.tipsRepository) : super(TipsState.initial());

  Future<void> addTips({required String tips}) async {
    emit(state.copyWith(isLoading: true, failureMessage: null, successMessage: null));
    try {
      await tipsRepository.addTip(tips);
      await getTips(); // سيقوم هذا بجلب القائمة الأحدث وتحديث الحالة
      emit(state.copyWith(isLoading: false, successMessage: 'تمت إضافة النصيحة بنجاح'));
    }catch(e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false , failureMessage: message));
    }
  }






  Future<void> getTips() async {
    emit(state.copyWith(
        isLoading: true, failureMessage: null, successMessage: null));

    try {
      final tipsList =  await tipsRepository.getTips();
      final lastThreeTips = tipsList.take(3).toList();

      print("✅ Tips fetched: ${tipsList.length}");
      print("✅ Tips tipsList: ${tipsList}");
      if (tipsList.isEmpty) {
        emit(state.copyWith(isLoading: false, tips: [], successMessage: 'لا توجد نصائح اليوم'));
      } else {
        emit(state.copyWith(isLoading: false, tips: tipsList, successMessage: 'تم جلب النصائح بنجاح'));
      }
    }catch(e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false , failureMessage: message));
    }
  }
  //
  // Future<void> getAllTips() async {
  //   emit(state.copyWith(
  //     isLoading: true,
  //     failureMessage: null,
  //     successMessage: null,
  //   ));
  //
  //   try {
  //     final tipsList = await tipsRepository.getTips();
  //
  //     emit(state.copyWith(
  //       isLoading: false,
  //       tips: tipsList,
  //       successMessage: tipsList.isEmpty ? null : 'تم جلب جميع النصائح بنجاح',
  //     ));
  //   } catch (e) {
  //     final message = ErrorHandler.handle(e);
  //     emit(state.copyWith(isLoading: false, failureMessage: message));
  //   }
  // }

  void clearMessages() {
    emit(state.copyWith(successMessage: null, failureMessage: null));
  }

}


// final response = await api.post(
// EndPoints.baseUrl + EndPoints.tips,
// options: Options(headers: {
// "Authorization": "Bearer ${await StorageHelper.getToken()}"
// }),
// data: {
// "advice": tips
// }
// );
// //final TipsModel tipsModel = TipsModel.fromJson(response['data']);