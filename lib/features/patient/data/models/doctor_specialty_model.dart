class DoctorSpecialtyModel {
  final int id;
  final String name;
  final String email;
  final String bio;
  final String image;
  final String specialtyNumber;
  final bool isFollowed;

  DoctorSpecialtyModel({
    required this.id,
    required this.name,
    required this.email,
    required this.bio,
    required this.image,
    required this.specialtyNumber,
    required this.isFollowed,
  });

  factory DoctorSpecialtyModel.fromJson(Map<String, dynamic> json) {
    return DoctorSpecialtyModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      bio: json['bio'] ?? '',
      image: json['img'] ?? 'images/doctor.png',
      specialtyNumber: json['jop_specialty_number'] ?? '',
      isFollowed: json['is_followed'] ?? false,
    );
  }

  DoctorSpecialtyModel copyWith({
    bool? isFollowed,
  }) {
    return DoctorSpecialtyModel(
      id: id,
      name: name,
      email: email,
      bio: bio,
      image: image,
      specialtyNumber: specialtyNumber,
      isFollowed: isFollowed ?? this.isFollowed,
    );
  }
}
