import 'doctor_model.dart';

class DoctorResponseModel {
  final DoctorModel user;
  final String token;

  DoctorResponseModel({
    required this.user,
    required this.token,
  });

  factory DoctorResponseModel.fromJson(Map<String, dynamic> json) {
    return DoctorResponseModel(
      user: DoctorModel.fromJson(json['user']),
      token: json['token'],
    );
  }
}

