import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/doctor_specialty_model.dart';
import '../data/repositories/patient_doctors_repository.dart';
import 'patient_doctors_state.dart';

class PatientDoctorsCubit extends Cubit<PatientDoctorsState> {
  final PatientDoctorsRepository repository;

  PatientDoctorsCubit(this.repository) : super(PatientDoctorsState());

  // دالة مساعدة للبحث عن طبيب أو ترجع null إذا مش موجود
  DoctorSpecialtyModel? findDoctorById(List<DoctorSpecialtyModel> list, int id) {
    for (var doctor in list) {
      if (doctor.id == id) return doctor;
    }
    return null;
  }

  void getDoctorsBySpecialty(String specialtyId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final doctors = await repository.getDoctorsBySpecialty(specialtyId);

      // استبعاد الأطباء الموجودين بالمتابعين
      final filteredDoctors = doctors.where((doctor) {
        return !state.followedDoctors.any((followedDoctor) => followedDoctor.id == doctor.id);
      }).toList();

      final updatedMap = Map<String, List<DoctorSpecialtyModel>>.from(state.specialtyDoctors);
      updatedMap[specialtyId] = filteredDoctors;

      emit(state.copyWith(
        isLoading: false,
        specialtyDoctors: updatedMap,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> getFollowedDoctors() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final followedDoctors = await repository.getFollowedDoctors();
      emit(state.copyWith(
        isLoading: false,
        followedDoctors: followedDoctors,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> toggleFollowDoctor(int doctorId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final isNowFollowed = await repository.toggleFollowDoctor(doctorId);

      final updatedSpecialtyDoctors = Map<String, List<DoctorSpecialtyModel>>.from(state.specialtyDoctors);
      final updatedFollowedDoctors = List<DoctorSpecialtyModel>.from(state.followedDoctors);

      DoctorSpecialtyModel? targetDoctor;

      // البحث في جميع التخصصات
      outerLoop:
      for (var doctorsList in updatedSpecialtyDoctors.values) {
        for (var doctor in doctorsList) {
          if (doctor.id == doctorId) {
            targetDoctor = doctor;
            break outerLoop;
          }
        }
      }

      // إذا الطبيب غير موجود في التخصصات، جرب تجيبه من المتابعين
      targetDoctor ??= findDoctorById(updatedFollowedDoctors, doctorId);

      if (targetDoctor != null) {
        if (isNowFollowed) {
          // إضافة للطبيب للمتابعين إذا مش موجود
          if (!updatedFollowedDoctors.any((doc) => doc.id == doctorId)) {
            updatedFollowedDoctors.add(targetDoctor.copyWith(isFollowed: true));
          }
        } else {
          // إزالة الطبيب من المتابعين
          updatedFollowedDoctors.removeWhere((doc) => doc.id == doctorId);
        }

        // تحديث حالة المتابعة في قائمة التخصصات
        updatedSpecialtyDoctors.forEach((key, doctorsList) {
          for (int i = 0; i < doctorsList.length; i++) {
            if (doctorsList[i].id == doctorId) {
              doctorsList[i] = doctorsList[i].copyWith(isFollowed: isNowFollowed);
              break;
            }
          }
        });
      }

      emit(state.copyWith(
        isLoading: false,
        specialtyDoctors: updatedSpecialtyDoctors,
        followedDoctors: updatedFollowedDoctors,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}


// class PatientDoctorsCubit extends Cubit<PatientDoctorsState> {
//   final PatientDoctorsRepository repository;
//
//   PatientDoctorsCubit(this.repository) : super(PatientDoctorsState());
//
//   void getDoctorsBySpecialty(int specialtyId) async {
//     emit(state.copyWith(isLoading: true));
//
//     try {
//       final doctors = await repository.getDoctorsBySpecialty(specialtyId);
//       final updatedMap = Map<int, List<DoctorSpecialtyModel>>.from(state.specialtyDoctors);
//       updatedMap[specialtyId] = doctors;
//
//       emit(state.copyWith(
//         isLoading: false,
//         specialtyDoctors: updatedMap,
//       ));
//     } catch (e) {
//       emit(state.copyWith(
//         isLoading: false,
//         errorMessage: e.toString(),
//       ));
//     }
//   }
//
//   void toggleFollowDoctor(int doctorId) {
//     final updatedSpecialtyDoctors = Map<int, List<DoctorSpecialtyModel>>.from(state.specialtyDoctors);
//     final updatedFollowedDoctors = List<DoctorSpecialtyModel>.from(state.followedDoctors);
//
//     DoctorSpecialtyModel? targetDoctor;
//
//     // نحذف الطبيب من كل التخصصات ونأخذ نسخة منه
//     updatedSpecialtyDoctors.forEach((specialtyId, doctorsList) {
//       doctorsList.removeWhere((doctor) {
//         if (doctor.id == doctorId) {
//           targetDoctor = doctor;
//           return true;
//         }
//         return false;
//       });
//     });
//
//     if (targetDoctor != null) {
//       if (targetDoctor!.isFollowed) {
//         // إلغاء المتابعة: نحذف الطبيب من قائمة المتابعين
//         updatedFollowedDoctors.removeWhere((doctor) => doctor.id == doctorId);
//       } else {
//         // متابعة: نضيف الطبيب إلى قائمة المتابعين
//         updatedFollowedDoctors.add(targetDoctor!.copyWith(isFollowed: true));
//       }
//
//       // نعيد بناء التخصصات بدون الطبيب
//       emit(state.copyWith(
//         specialtyDoctors: updatedSpecialtyDoctors,
//         followedDoctors: updatedFollowedDoctors,
//       ));
//     }
//   }
//
//
// }
