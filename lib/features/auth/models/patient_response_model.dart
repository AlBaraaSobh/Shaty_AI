import 'PatientRegisterModel .dart';

class PatientResponseModel {
  final PatientRegisterModel user;
  final String token;

  PatientResponseModel({required this.user, required this.token});

  factory PatientResponseModel.fromJson(Map<String,dynamic> json){
  return PatientResponseModel(user: PatientRegisterModel.fromJson(json['user']),
    token: json['token'],
  );
  }
}