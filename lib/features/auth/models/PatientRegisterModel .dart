class PatientRegisterModel {
  final int? id;
  final String? name;
  final String? email;
  final String password;
  final String password_confirmation;
  final String? img;
  final bool is_doctor;

  PatientRegisterModel(
      {this.id,
      this.img,
      required this.name,
      required this.email,
      required this.password,
      required this.password_confirmation,
      this.is_doctor = false});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'img': img,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'is_doctor': is_doctor,
    };
  }

  factory PatientRegisterModel.fromJson(Map<String, dynamic> json) {
    return PatientRegisterModel(
      id: json['id'],
      name: json['name'] as String?,
      email: json['email'] as String?,
      img: json['img'] as String?,
      password: '',
      password_confirmation: '',
    );
  }
}
