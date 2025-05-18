class ArticleDoctorModel {
  final int id;
  final String name;
  final String email;
  final String? img;

  ArticleDoctorModel({
    required this.id,
    required this.name,
    required this.email,
    this.img,
  });

  factory ArticleDoctorModel.fromJson(Map<String, dynamic> json) {
    return ArticleDoctorModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      img: json['img'],
    );
  }

}
