class DoctorRegisterModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final bool isDoctor;
  final String jobSpecialtyNumber;
  final String specialtyId;

  DoctorRegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.isDoctor,
    required this.jobSpecialtyNumber,
    required this.specialtyId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'is_doctor': isDoctor,
      'jop_specialty_number': jobSpecialtyNumber,
      'specialty_id': specialtyId,
    };
  }
}
