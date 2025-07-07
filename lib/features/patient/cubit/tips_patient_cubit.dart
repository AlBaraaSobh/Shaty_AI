import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/patient/cubit/tips_patient_state.dart';
import 'package:shaty/features/patient/data/repositories/tips_patient_repository.dart';

class TipsPatientCubit extends Cubit<TipsPatientState> {
  final TipsPatientRepository repository;

  TipsPatientCubit(this.repository) : super(TipsPatientState());

  Future<void> fetchTodayAdvice() async {
    emit(state.copyWith(isLoading: true));
    try {
      final tips = await repository.getTodayAdvice();
      emit(state.copyWith(isLoading: false, tips: tips));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}