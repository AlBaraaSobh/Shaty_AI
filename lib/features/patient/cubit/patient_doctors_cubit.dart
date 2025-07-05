import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/doctor_specialty_model.dart';
import '../data/repositories/patient_doctors_repository.dart';
import 'patient_doctors_state.dart';

class PatientDoctorsCubit extends Cubit<PatientDoctorsState> {
  final PatientDoctorsRepository repository;

  PatientDoctorsCubit(this.repository) : super(PatientDoctorsState.initial());

  // كاش مخصص لتخزين الأطباء حسب التخصص
  Map<int, List<DoctorSpecialtyModel>> cachedDoctorsBySpecialty = {};
  List<DoctorSpecialtyModel>? cachedFollowedDoctors;

  Future<void> getAllDoctors() async {
    if (cachedFollowedDoctors != null) {
      emit(state.copyWith(followedDoctors: cachedFollowedDoctors!));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final doctors = await repository.getDoctors();
      cachedFollowedDoctors = doctors;
      emit(state.copyWith(isLoading: false, followedDoctors: doctors));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> getDoctorsBySpecialty(int specialtyId) async {
    if (cachedDoctorsBySpecialty.containsKey(specialtyId)) {
      emit(state.copyWith(
        doctors: cachedDoctorsBySpecialty[specialtyId]!,
        isLoading: false,
        errorMessage: null,
      ));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final doctors = await repository.getDoctorsBySpecialty(specialtyId);
      cachedDoctorsBySpecialty[specialtyId] = doctors;
      emit(state.copyWith(isLoading: false, doctors: doctors));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> toggleFollowDoctor(int doctorId) async {
    try {
      final isFollowing = await repository.toggleFollowDoctor(doctorId);

      // تحديث قائمة المتابعين
      List<DoctorSpecialtyModel> updatedFollowed;
      if (isFollowing) {
        final doctor = findDoctorByIdFromAll(doctorId);
        if (doctor != null) {
          updatedFollowed = List.from(state.followedDoctors)
            ..add(doctor.copyWith(isFollowed: true));
        } else {
          updatedFollowed = state.followedDoctors;
        }
      } else {
        updatedFollowed =
            state.followedDoctors.where((d) => d.id != doctorId).toList();
      }

      // تحديث القائمة الحالية المعروضة
      final updatedDoctors = state.doctors.map((d) {
        if (d.id == doctorId) {
          return d.copyWith(isFollowed: isFollowing);
        }
        return d;
      }).toList();

      // تحديث الكاش لكل تخصص
      cachedDoctorsBySpecialty.forEach((key, list) {
        cachedDoctorsBySpecialty[key] = list.map((d) {
          if (d.id == doctorId) {
            return d.copyWith(isFollowed: isFollowing);
          }
          return d;
        }).toList();
      });

      cachedFollowedDoctors = updatedFollowed;

      emit(state.copyWith(
        followedDoctors: updatedFollowed,
        doctors: updatedDoctors,
      ));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  DoctorSpecialtyModel? findDoctorByIdFromAll(int id) {
    for (var list in cachedDoctorsBySpecialty.values) {
      for (var doctor in list) {
        if (doctor.id == id) return doctor;
      }
    }
    return null;
  }
}
