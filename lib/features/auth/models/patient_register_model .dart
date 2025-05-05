class PatientRegisterModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final bool isDoctor;

  PatientRegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    this.isDoctor = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'is_doctor': isDoctor,
    };
  }
}
