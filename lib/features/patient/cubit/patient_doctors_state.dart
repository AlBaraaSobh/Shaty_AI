import '../data/models/doctor_specialty_model.dart';

class PatientDoctorsState {
  final bool isLoading;
  final bool isLocalLoading;
  final String? errorMessage;
  final List<DoctorSpecialtyModel> doctors; // أطباء التخصص الحالي
  final List<DoctorSpecialtyModel> followedDoctors;

  PatientDoctorsState({
    this.isLoading = false,
    this.isLocalLoading = false,
    this.errorMessage,
    this.doctors = const [],
    this.followedDoctors = const [],
  });

  factory PatientDoctorsState.initial() => PatientDoctorsState();

  PatientDoctorsState copyWith({
    bool? isLoading,
    bool? isLocalLoading,
    String? errorMessage,
    List<DoctorSpecialtyModel>? doctors,
    List<DoctorSpecialtyModel>? followedDoctors,
  }) {
    return PatientDoctorsState(
      isLoading: isLoading ?? this.isLoading,
      isLocalLoading: isLocalLoading ?? this.isLocalLoading,
      errorMessage: errorMessage,
      doctors: doctors ?? this.doctors,
      followedDoctors: followedDoctors ?? this.followedDoctors,
    );
  }
}
