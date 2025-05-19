import 'article_doctor_model.dart';
import 'article_info_model.dart';

class ArticleModel {
  final int id;
  final String title;
  final String subject;
  final String? img;
  final ArticleDoctorModel doctor;
  final ArticleInfoModel articleInfo;
  final String createdAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.img,
    required this.doctor,
    required this.articleInfo,
    required this.createdAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      subject: json['subject'],
      img: json['img'],
      doctor: ArticleDoctorModel.fromJson(json['doctor']),
      articleInfo: ArticleInfoModel.fromJson(json['article_info']),
      createdAt: json['created_at'],
    );
  }


}
