import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../features/doctor/cubit/comment_cubit.dart';
import '../../features/doctor/cubit/comment_state.dart';

class PostDetailsScreen extends StatefulWidget {
  final int articleId;
  final String postContent;
  final String? postImage;


  const PostDetailsScreen({
    super.key,
    required this.articleId,
    required this.postContent,
    this.postImage,
  });

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {

  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CommentCubit>().fetchComments(widget.articleId.toString());
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isNotEmpty) {
      context.read<CommentCubit>().addComment(
          widget.articleId.toString(), text);
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المنشور'),
      ),
      body: Column(
        children: [
          // نص البوست الأساسي
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: AppColors.primaryColor.withOpacity(0.1),
            child: Text(
              widget.postContent,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),

          // قائمة التعليقات
          Expanded(
            child: BlocBuilder<CommentCubit, CommentState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.failureMessage != null) {
                  return Center(child: Text(state.failureMessage!));
                }
                if (state.comments.isEmpty) {
                  return const Center(child: Text('لا توجد تعليقات حتى الآن.'));
                }
                return ListView.separated(
                  itemCount: state.comments.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final comment = state.comments[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(comment.user.name),
                      subtitle: Text(comment.comment),
                    );
                  },
                );
              },
            ),
          ),

          // حقل إدخال تعليق محسن
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'اكتب تعليقك هنا...',
                        border: InputBorder.none, // بدون إطار داخلي
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _addComment,
                    icon: const Icon(Icons.send, color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
