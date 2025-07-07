import '../data/models/doctor_specialty_model.dart';


class PatientDoctorsState {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, List<DoctorSpecialtyModel>> specialtyDoctors;
  final List<DoctorSpecialtyModel> followedDoctors;

  PatientDoctorsState({
    this.isLoading = false,
    this.errorMessage,
    this.specialtyDoctors = const {},
    this.followedDoctors = const [],
  });

  PatientDoctorsState copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, List<DoctorSpecialtyModel>>? specialtyDoctors,
    List<DoctorSpecialtyModel>? followedDoctors,
  }) {
    return PatientDoctorsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      specialtyDoctors: specialtyDoctors ?? this.specialtyDoctors,
      followedDoctors: followedDoctors ?? this.followedDoctors,
    );
  }
}


// class PatientDoctorsState {
//   final bool isLoading;
//   final Map<int, List<DoctorSpecialtyModel>> specialtyDoctors;
//   final String? errorMessage;
//
//   PatientDoctorsState({
//     this.isLoading = false,
//     this.specialtyDoctors = const {},
//     this.errorMessage,
//   });
//
//   PatientDoctorsState copyWith({
//     bool? isLoading,
//     Map<int, List<DoctorSpecialtyModel>>? specialtyDoctors,
//     String? errorMessage,
//   }) {
//     return PatientDoctorsState(
//       isLoading: isLoading ?? this.isLoading,
//       specialtyDoctors: specialtyDoctors ?? this.specialtyDoctors,
//       errorMessage: errorMessage,
//     );
//   }
// }
