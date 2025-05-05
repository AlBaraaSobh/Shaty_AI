class DoctorUser {
  final int id;
  final String name;
  final String email;
  final String? bio;
  final String? img;
  final String jobSpecialtyNumber;

  DoctorUser({
    required this.id,
    required this.name,
    required this.email,
    this.bio,
    this.img,
    required this.jobSpecialtyNumber,
  });

  factory DoctorUser.fromJson(Map<String, dynamic> json) {
    return DoctorUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      bio: json['bio'],
      img: json['img'],
      jobSpecialtyNumber: json['jop_specialty_number'],
    );
  }
//عشان رح تلزمك في حال بدك تعدل بيانات
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'bio': bio,
      'img': img,
      'jop_specialty_number': jobSpecialtyNumber,
    };
  }

}
