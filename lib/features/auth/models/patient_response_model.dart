
import 'package:shaty/features/auth/models/patient_model.dart';

class PatientResponseModel {
  final PatientModel user;
  final String token;

  PatientResponseModel({
    required this.user,
    required this.token,
  });

  factory PatientResponseModel.fromJson(Map<String, dynamic> json) {
    return PatientResponseModel(
      user: PatientModel.fromJson(json['user']),
      token: json['token'],
    );
  }

}
