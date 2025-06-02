import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/doctor/data/models/article_model.dart';
import '../../../../shared/common/post_details_screen.dart';
import '../cubit/article_cubit.dart';

class ArticleCard extends StatelessWidget {
  final ArticleModel article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            _buildHeader(),
            const SizedBox(height: 12),
            Text(article.subject, style: const TextStyle(fontSize: 16)),
            if (article.img != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.img!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, size: 48),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('images/doctor.png'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(article.doctor.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(article.doctor.email, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              // TODO: تنفيذ التعديل
            } else if (value == 'delete') {
              // TODO: تنفيذ الحذف
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'edit', child: Text('تعديل')),
            PopupMenuItem(value: 'delete', child: Text('حذف')),
          ],
          icon: const Icon(Icons.more_horiz),
        ),
      ],
    );
  }


  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _PostAction(
            icon: article.articleInfo.isLiked ? Icons.favorite : Icons.favorite_border,
            label: '${article.articleInfo.numLikes}',
            iconColor: article.articleInfo.isLiked ? Colors.red : Colors.grey[700],
            onPressed: () {
              context.read<ArticleCubit>().likeArticle(article.id);
            },
        ),
        _PostAction(
          icon: Icons.comment_outlined,
          label: '${article.articleInfo.numComments} ',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PostDetailsScreen(
                  postContent: article.subject,
                  articleId: article.id,
                ),
              ),
            );
          },
        ),
        _PostAction(icon: Icons.share_outlined, label: '', onPressed: () {}),
        _PostAction(
          icon: article.articleInfo.isSaved ? Icons.bookmark : Icons.bookmark_border,
          label: '',
          onPressed: () {
            // TODO: تنفيذ الحفظ
          },
        ),
      ],
    );
  }

}

class _PostAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? iconColor;

  const _PostAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, size: 22, color: iconColor ?? Colors.grey[700]),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }
}

