import 'package:shaty/features/doctor/data/models/specialty_model.dart';

class DoctorsModel {
  final int id;
  final String name;
  final String email;
  final String? img;
  final String? bio;
  final String jopSpecialtyNumber;
  final List<SpecialtyModel> specialties;

  DoctorsModel({
    required this.id,
    required this.name,
    required this.email,
    required this.jopSpecialtyNumber,
    this.img,
    this.bio,
    required this.specialties,
  });

  factory DoctorsModel.fromJson(Map<String, dynamic> json) {
    return DoctorsModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      img: json['img'],
      bio: json['bio'],
      jopSpecialtyNumber: json['jop_specialty_number'],
      specialties: (json['specialty'] as List<dynamic>)
          .map((e) => SpecialtyModel.fromJson(e))
          .toList(),
    );
  }
}