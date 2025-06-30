import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/doctor/cubit/doctor_profile_cubit.dart';
import 'package:shaty/features/shared/settings/data/repositories/edit_profile_repository.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileRepository repository;
  final DoctorProfileCubit doctorProfileCubit;

  EditProfileCubit(this.repository, this.doctorProfileCubit)
      : super(EditProfileState.initial());

  Future<void> updateProfile({
    required String name,
    required String email,
    required String bio,
    required String specialtyNumber,
    File? image,
  }) async {
    final oldDoctor = doctorProfileCubit.state.doctor;

    final noChanges = oldDoctor != null &&
        oldDoctor.name == name &&
        oldDoctor.email == email &&
        (oldDoctor.bio ?? '') == bio &&
        oldDoctor.jobSpecialtyNumber == specialtyNumber &&
        image == null;

    if (noChanges) {
      emit(state.copyWith(failureMessage: 'لم تقم بأي تعديل.'));
      return;
    }

    emit(state.copyWith(isLoading: true, successMessage: null, failureMessage: null));

    try {
      final message = await repository.updateProfile(
        name: name,
        email: email,
        bio: bio,
        specialtyNumber: specialtyNumber,
        imagePath: image?.path,
      );

      emit(state.copyWith(isLoading: false, successMessage: message));
    } catch (e) {
      emit(state.copyWith(isLoading: false, failureMessage: 'فشل تحديث الملف الشخصي'));
    }
  }

  void clearMessages() {
    emit(state.copyWith(successMessage: null, failureMessage: null));
  }
}

// import 'dart:io';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shaty/features/shared/settings/data/repositories/edit_profile_repository.dart';
// import 'edit_profile_state.dart';
//
// class EditProfileCubit extends Cubit<EditProfileState> {
//   final EditProfileRepository repository;
//
//   EditProfileCubit(this.repository) : super(EditProfileState.initial());
//
//   Future<void> updateProfile({
//     required String name,
//     required String email,
//     required String bio,
//     required String specialtyNumber,
//     File? image,
//   }) async {
//     emit(state.copyWith(isLoading: true, successMessage: null, failureMessage: null));
//
//     try {
//       final message = await repository.updateProfile(
//         name: name,
//         email: email,
//         bio: bio,
//         specialtyNumber: specialtyNumber,
//         imagePath: image?.path,
//       );
//
//       emit(state.copyWith(isLoading: false, successMessage: message));
//     } catch (e) {
//       emit(state.copyWith(isLoading: false, failureMessage: 'فشل تحديث الملف الشخصي'));
//     }
//   }
//
//   void clearMessages() {
//     emit(state.copyWith(successMessage: null, failureMessage: null));
//   }
// }
