class CommentModel {
  final int id;
  final String comment;
  final int articleId;
  final String createdAt;
  final String updatedAt;
  final CommentUser user;

  CommentModel({
    required this.id,
    required this.comment,
    required this.articleId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      comment: json['comment'],
      articleId: json['article_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: CommentUser.fromJson(json['user']),
    );
  }
}

class CommentUser {
  final int id;
  final String name;
  final String email;
  final String? img;

  CommentUser({
    required this.id,
    required this.name,
    required this.email,
    this.img,
  });

  factory CommentUser.fromJson(Map<String, dynamic> json) {
    return CommentUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      img: json['img'] != null
          ? json['img'].toString().replaceAll('127.0.0.1', '10.0.2.2')
          : null,
    );
  }
}
