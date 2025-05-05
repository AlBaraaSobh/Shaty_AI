import 'doctor_model.dart';

class DoctorResponseModel {
  final DoctorUser user;
  final String token;

  DoctorResponseModel({
    required this.user,
    required this.token,
  });

  factory DoctorResponseModel.fromJson(Map<String, dynamic> json) {
    return DoctorResponseModel(
      user: DoctorUser.fromJson(json['user']),
      token: json['token'],
    );
  }
}

