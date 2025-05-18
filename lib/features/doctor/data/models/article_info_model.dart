class ArticleInfoModel {
  final int numComments;
  final int numLikes;
  final bool isLiked;
  final bool isSaved;

  ArticleInfoModel({
    required this.numComments,
    required this.numLikes,
    required this.isLiked,
    required this.isSaved,
  });

  factory ArticleInfoModel.fromJson(Map<String, dynamic> json) {
    return ArticleInfoModel(
      numComments: json['num_comments'],
      numLikes: json['num_likes'],
      isLiked: json['is_liked'],
      isSaved: json['is_saved'],
    );
  }
}
