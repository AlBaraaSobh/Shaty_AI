import 'package:flutter/material.dart';
import 'package:shaty/core/extensions/localization_extension.dart';


import '../../../core/constants/app_colors.dart';
import '../../../shared/common/post_details_screen.dart';
import '../data/models/article_model.dart';

class DoctorPostsSection extends StatelessWidget {


  const DoctorPostsSection({super.key});


  @override
  Widget build(BuildContext context) {
    final posts = [
      {
        'name': 'د. البراء صبح',
        'username': '@alBaraa96',
        'content': 'هذا منشور يحتوي على نص فقط بدون صورة.',
        'profileImage': 'images/doctor.png',
        'postImage': null,
      },
      {
        'name': 'د. سارة منصور',
        'username': '@drSara',
        'content': 'هذا منشور يحتوي على نص وصورة مرفقة.',
        'profileImage': 'images/doctor.png',
        'postImage': 'images/post.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            context.loc.new_post,
            style: const TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: posts.length,
          separatorBuilder: (_, __) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            final post = posts[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header Row
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage(post['profileImage']!),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                post['username']!,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_horiz),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    /// Post Text
                    Text(
                      post['content']!,
                      style: const TextStyle(fontSize: 16),
                    ),

                    /// Post Image if available
                    if (post['postImage'] != null) ...[
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          post['postImage']!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),

                    /// Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PostAction(
                          icon: Icons.favorite_border,
                          label: 'إعجاب',
                          onPressed: () {},
                        ),
                        PostAction(
                          icon: Icons.comment_outlined,
                          label: 'تعليق',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailsScreen(
                                  postContent: post['content']!, articleId: 1,
                                ),
                              ),
                            );
                          },
                        ),
                        PostAction(
                          icon: Icons.share_outlined,
                          label: 'مشاركة',
                          onPressed: () {},
                        ),
                        PostAction(
                          icon: Icons.bookmark_border,
                          label: 'حفظ',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class PostAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const PostAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, size: 22, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}


class ArticleCard extends StatelessWidget {
  final ArticleModel article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المقالة
          if (article.img != null && article.img!.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                article.img!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 100),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // عنوان المقالة
                Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // نص المقالة
                Text(
                  article.subject,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
