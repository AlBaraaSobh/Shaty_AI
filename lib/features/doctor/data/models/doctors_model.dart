import 'package:shaty/features/doctor/data/models/specialty_model.dart';

class DoctorsModel {
  final int id;
  final String name;
  final String email;
  final String? img;
  final String? bio;
  final String jobSpecialtyNumber;
  final List<SpecialtyModel> specialties;

  DoctorsModel({
    required this.id,
    required this.name,
    required this.email,
    required this.jobSpecialtyNumber,
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
      jobSpecialtyNumber: json['jop_specialty_number'],
      specialties: (json['specialty'] as List<dynamic>)
          .map((e) => SpecialtyModel.fromJson(e))
          .toList(),
    );
  }

  DoctorsModel copyWith({
    int? id,
    String? name,
    String? email,
    String? bio,
    String? img,
    String? jobSpecialtyNumber,
  }) {
    return DoctorsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      img: img ?? this.img,
      jobSpecialtyNumber: jobSpecialtyNumber ?? this.jobSpecialtyNumber,
      specialties: specialties ?? this.specialties,
    );
  }
}
