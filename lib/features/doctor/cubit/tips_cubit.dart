import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/errors/exceptions.dart';
import 'package:shaty/features/doctor/cubit/tips_state.dart';
import 'package:shaty/features/doctor/data/repositories/tips_repository.dart';


class TipsCubit extends Cubit<TipsState> {
  final TipsRepository tipsRepository;

  TipsCubit(this.tipsRepository) : super(TipsState.initial());

  Future<void> addTips({required String tips}) async {
    emit(state.copyWith(
        isLoading: true, failureMessage: null, successMessage: null));
    try {
      await tipsRepository.addTip(tips);
      await getTips();
      emit(state.copyWith(
          isLoading: false, successMessage: 'تمت إضافة النصيحة بنجاح'));
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }

  Future<void> deleteTip(int id) async {
    emit(state.copyWith(
        isLoading: true, failureMessage: null, successMessage: null));
    try {
      await tipsRepository.deleteTips(id);
      emit(state.copyWith(successMessage: 'تم الحذف بنجاح'));
      await getTips();
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }

  Future<void> updateTip(String id, String advice) async {
    emit(state.copyWith(
        isLoading: true, failureMessage: null, successMessage: null));
    try {
      final updatedAdvice =
          await tipsRepository.updateTip(id: id, advice: advice);
      final updatedList = state.tips.map((e) => e.id == updatedAdvice.id ? updatedAdvice : e).toList(); //تحديث النصيحة المعدلة فقط

      emit(state.copyWith(
          isLoading: false,
          tips: updatedList,
          successMessage: 'تم التعديل بنجاح'));
      await getTips();
    } catch (e) {
      final message = ErrorHandler.handle(e);
      emit(state.copyWith(isLoading: false, failureMessage: message));
    }
  }

  Future<void> getTips() async {
    emit(state.copyWith(
        isLoading: true, failureMessage: null, successMessage: null));

    try {
      final tipsList = await tipsRepository.getTips();
      if (tipsList.isEmpty) {
        emit(state.copyWith(
            isLoading: false, tips: [], successMessage: 'لا توجد نصائح اليوم'));
      } else {
        emit(state.copyWith(
          isLoading: false,
          tips: tipsList,
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
