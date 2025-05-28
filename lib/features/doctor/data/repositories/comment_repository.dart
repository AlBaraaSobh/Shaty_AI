import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/end_points.dart';
import '../models/comment_model.dart';

class CommentRepository {
  final ApiConsumer api;

  CommentRepository(this.api);

  Future<void> addComment({
    required String articleId,
    required String commentText,
  }) async {
    await api.post(
      EndPoints.commentArticle(articleId),
      data: {'comment': commentText},
    );
  }

  Future<List<CommentModel>>fetchComments(String articleId) async {
    final response = await api.get(EndPoints.getCommentArticle(articleId));
    if (response is List) {
      return response.map((json) => CommentModel.fromJson(json)).toList();
    } else {
      throw Exception('Unexpected response format: $response');
    }  }

  Future<void> deleteComment(String commentId) async {
    await api.delete(EndPoints.deleteCommentArticle(commentId));
  }



}



