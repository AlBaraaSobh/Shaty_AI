class PatientModel {
  final int id;
  final String name;
  final String email;
  final String? img;

  PatientModel({
    required this.id,
    required this.name,
    required this.email,
    this.img,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      img: json['img'],
    );
  }
}
