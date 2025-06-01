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

  ArticleInfoModel copyWith({
    int? numComments,
    int? numLikes,
    bool? isLiked,
    bool? isSaved,
  }) {
    return ArticleInfoModel(
      numComments: numComments ?? this.numComments,
      numLikes: numLikes ?? this.numLikes,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
