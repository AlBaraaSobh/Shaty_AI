import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/patient_profile_repository.dart';
import 'patient_profile_state.dart';

class PatientProfileCubit extends Cubit<PatientProfileState> {
  final PatientProfileRepository repository;

  PatientProfileCubit(this.repository) : super(PatientProfileState());

  Future<void> updateProfile({
    required String name,
    required String email,
    File? image,
  }) async {
    emit(state.copyWith(isLoading: true, successMessage: null, failureMessage: null));
    try {
      await repository.updateProfile(name: name, email: email, image: image);
      emit(state.copyWith(isLoading: false, successMessage: 'تم تحديث الملف الشخصي بنجاح'));
    } catch (error) {
      emit(state.copyWith(isLoading: false, failureMessage: error.toString()));
    }
  }

  void clearMessages() {
    emit(state.copyWith(successMessage: null, failureMessage: null));
  }
}
