import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/constants/app_colors.dart';
import '../../core/utils/helpers/helpers.dart';
import '../../features/doctor/cubit/article_cubit.dart';
import '../../features/doctor/cubit/comment_cubit.dart';
import '../../features/doctor/cubit/comment_state.dart';
import '../widgets/show_alert_Dialog.dart';

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
  int? _editingCommentId;

  @override
  void initState() {
    super.initState();
    _setupTimeAgoMessages();
    context.read<CommentCubit>().fetchComments(widget.articleId.toString());
  }

  void _setupTimeAgoMessages() {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  // void _addOrUpdateComment() {
  //   final text = _commentController.text.trim();
  //   if (text.isEmpty) return;
  //
  //   final cubit = context.read<CommentCubit>();
  //
  //   if (_editingCommentId == null) {
  //     cubit.addComment(widget.articleId.toString(), text);
  //   } else {
  //     // TODO: تنفيذ منطق التعديل من الكيوبت
  //     // cubit.updateComment(_editingCommentId!, text);
  //   }
  //
  //   _commentController.clear();
  //   _editingCommentId = null;
  //   setState(() {}); // لتحديث حالة الزر والنص
  // }

  void _addOrUpdateComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    final cubit = context.read<CommentCubit>();
    final articleCubit = context.read<ArticleCubit>();

    if (_editingCommentId == null) {
      await cubit.addComment(widget.articleId.toString(), text);
      articleCubit.incrementCommentCount(widget.articleId); // ⭐️ تحديث العداد
    } else {
      // TODO: تنفيذ منطق التعديل من الكيوبت
      // cubit.updateComment(_editingCommentId!, text);
    }

    _commentController.clear();
    _editingCommentId = null;
    setState(() {});
  }


  void _startEdit(int commentId, String oldText) {
    _commentController.text = oldText;
    _editingCommentId = commentId;
    setState(() {});
  }

  void _cancelEdit() {
    _commentController.clear();
    _editingCommentId = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المنشور'),
      ),
      body: Column(
        children: [
          // نص البوست
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: AppColors.primaryColor.withOpacity(0.1),
            child:
                Text(widget.postContent, style: const TextStyle(fontSize: 18)),
          ),
          const Divider(),

          // قائمة التعليقات
          Expanded(
            child: BlocBuilder<CommentCubit, CommentState>(
              builder: (context, state) {
                if (state.isLoading)
                  return const Center(child: CircularProgressIndicator());
                if (state.failureMessage != null)
                  return Center(child: Text(state.failureMessage!));
                if (state.comments.isEmpty)
                  return const Center(child: Text('لا توجد تعليقات حتى الآن.'));

                return ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.comments.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final comment = state.comments[index];
                    final timeAgo = timeago.format(
                        DateTime.parse(comment.createdAt),
                        locale: 'ar');

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        backgroundImage: comment.user.img != null
                            ? NetworkImage(comment.user.img!)
                            : const AssetImage('images/doctor.png')
                                as ImageProvider,
                      ),
                      title: Text(comment.user.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comment.comment),
                          const SizedBox(height: 4),
                          Text(
                            timeAgo,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            _startEdit(comment.id, comment.comment);
                          } else if (value == 'delete') {
                            showDialog(
                              context: context,
                              builder: (context) => ShowAlertDialog(
                                title: 'هل تريد حذف التعليق؟',
                                action: 'حذف',
                                onConfirmed: () {
                                  Navigator.of(context).pop();
                                  context.read<CommentCubit>().deleteComment(
                                      comment.id.toString(),
                                      widget.articleId.toString());
                                },
                              ),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                              value: 'edit', child: Text('تعديل')),
                          const PopupMenuItem(
                              value: 'delete', child: Text('حذف')),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // إدخال تعليق أو تعديل
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
                      decoration: InputDecoration(
                        hintText: _editingCommentId == null
                            ? 'اكتب تعليقك هنا...'
                            : 'تعديل التعليق...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (_editingCommentId != null)
                    IconButton(
                      onPressed: _cancelEdit,
                      icon: const Icon(Icons.close, color: Colors.red),
                    ),
                  IconButton(
                    onPressed: _addOrUpdateComment,
                    icon: Icon(
                      _editingCommentId == null ? Icons.send : Icons.check,
                      color: AppColors.primaryColor,
                    ),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../features/doctor/cubit/comment_cubit.dart';
// import '../../features/doctor/cubit/comment_state.dart';
//
// class PostDetailsScreen extends StatefulWidget {
//   final int articleId;
//   final String postContent;
//   final String? postImage;
//
//   const PostDetailsScreen({
//     super.key,
//     required this.articleId,
//     required this.postContent,
//     this.postImage,
//   });
//
//   @override
//   State<PostDetailsScreen> createState() => _PostDetailsScreenState();
// }
//
// class _PostDetailsScreenState extends State<PostDetailsScreen> {
//   final TextEditingController _commentController = TextEditingController();
//   int? _editingCommentId;
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<CommentCubit>().fetchComments(widget.articleId.toString());
//   }
//
//   @override
//   void dispose() {
//     _commentController.dispose();
//     super.dispose();
//   }
//
//   void _addOrUpdateComment() {
//     final text = _commentController.text.trim();
//     if (text.isEmpty) return;
//
//     final cubit = context.read<CommentCubit>();
//
//     if (_editingCommentId == null) {
//       cubit.addComment(widget.articleId.toString(), text);
//     } else {
//       // TODO: تنفيذ منطق التعديل من الكيوبت
//       // cubit.updateComment(_editingCommentId!, text);
//     }
//
//     _commentController.clear();
//     _editingCommentId = null;
//     setState(() {}); // لتحديث حالة الزر والنص
//   }
//
//   void _startEdit(int commentId, String oldText) {
//     _commentController.text = oldText;
//     _editingCommentId = commentId;
//     setState(() {});
//   }
//
//   void _cancelEdit() {
//     _commentController.clear();
//     _editingCommentId = null;
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('تفاصيل المنشور'),
//       ),
//       body: Column(
//         children: [
//           // نص البوست
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             color: AppColors.primaryColor.withOpacity(0.1),
//             child:
//                 Text(widget.postContent, style: const TextStyle(fontSize: 18)),
//           ),
//           const Divider(),
//
//           // قائمة التعليقات
//           Expanded(
//             child: BlocBuilder<CommentCubit, CommentState>(
//               builder: (context, state) {
//                 if (state.isLoading)
//                   return const Center(child: CircularProgressIndicator());
//                 if (state.failureMessage != null)
//                   return Center(child: Text(state.failureMessage!));
//                 if (state.comments.isEmpty)
//                   return const Center(child: Text('لا توجد تعليقات حتى الآن.'));
//
//                 return ListView.separated(
//                   padding: const EdgeInsets.all(8),
//                   itemCount: state.comments.length,
//                   separatorBuilder: (_, __) => const Divider(),
//                   itemBuilder: (context, index) {
//                     final comment = state.comments[index];
//                     return ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: AppColors.primaryColor,
//                         child: const Icon(Icons.person, color: Colors.white),
//                       ),
//                       title: Text(comment.user.name),
//                       subtitle: Text(comment.comment),
//                       trailing: PopupMenuButton<String>(
//                         onSelected: (value) {
//                           if (value == 'edit') {
//                             _startEdit(comment.id, comment.comment);
//                           } else if (value == 'delete') {
//                             context.read<CommentCubit>().deleteComment(
//                                 comment.id.toString(),
//                                 widget.articleId.toString());
//                           }
//                         },
//                         itemBuilder: (context) => [
//                           const PopupMenuItem(
//                               value: 'edit', child: Text('تعديل')),
//                           const PopupMenuItem(
//                               value: 'delete', child: Text('حذف')),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//
//           // إدخال تعليق أو تعديل
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(30),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _commentController,
//                       decoration: InputDecoration(
//                         hintText: _editingCommentId == null
//                             ? 'اكتب تعليقك هنا...'
//                             : 'تعديل التعليق...',
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   if (_editingCommentId != null)
//                     IconButton(
//                       onPressed: _cancelEdit,
//                       icon: const Icon(Icons.close, color: Colors.red),
//                     ),
//                   IconButton(
//                     onPressed: _addOrUpdateComment,
//                     icon: Icon(
//                       _editingCommentId == null ? Icons.send : Icons.check,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
