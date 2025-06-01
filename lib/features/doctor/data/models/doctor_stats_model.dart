class DoctorStatsModel {
  final String doctorName;
  final String? doctorImg;
  final int numberOfFollowers;
  final int numberOfArticles;
  final int numberOfAdvice;

  DoctorStatsModel({
    required this.doctorName,
    required this.doctorImg,
    required this.numberOfFollowers,
    required this.numberOfArticles,
    required this.numberOfAdvice,
  });

  factory DoctorStatsModel.fromJson(Map<String, dynamic> json) {
    return DoctorStatsModel(
      doctorName: json['doctor_name'],
      doctorImg: json['doctor_img'],
      numberOfFollowers: json['number_of_followers'],
      numberOfArticles: json['number_of_articles'],
      numberOfAdvice: json['number_of_advice'],
    );
  }
}
