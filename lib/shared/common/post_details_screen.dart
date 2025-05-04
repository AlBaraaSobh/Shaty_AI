import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PostDetailsScreen extends StatefulWidget {
  final String postContent;
  final String? postImage;


  const PostDetailsScreen({super.key, required this.postContent, this.postImage});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final List<String> comments = [
    'رائع جدًا!',
    'معلومة مفيدة شكرًا لك.',
    'نصيحة جميلة ❤️',
  ];

  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        comments.add(text);
      });
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
            child: ListView.separated(
              itemCount: comments.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(comments[index]),
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
