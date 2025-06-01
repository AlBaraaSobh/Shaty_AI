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
    String? imageUrl = json['img'];

    // تحويل localhost إلى 10.0.2.2 ليشتغل في المحاكي
    if (imageUrl != null) {
      imageUrl = imageUrl.replaceAll('127.0.0.1', '10.0.2.2');
    }

    return ArticleModel(
      id: json['id'],
      title: json['title'],
      subject: json['subject'],
      img: imageUrl,
      doctor: ArticleDoctorModel.fromJson(json['doctor']),
      articleInfo: ArticleInfoModel.fromJson(json['article_info']),
      createdAt: json['created_at'],

    );
  }

  ArticleModel copyWith({
    int? id,
    String? title,
    String? subject,
    String? img,
    ArticleDoctorModel? doctor,
    ArticleInfoModel? articleInfo,
    String? createdAt,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      img: img ?? this.img,
      doctor: doctor ?? this.doctor,
      articleInfo: articleInfo ?? this.articleInfo,
      createdAt: createdAt ?? this.createdAt,

    );
  }
}
