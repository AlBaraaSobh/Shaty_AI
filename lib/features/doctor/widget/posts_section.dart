import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/features/doctor/cubit/article_cubit.dart';
import 'package:shaty/features/doctor/cubit/article_state.dart';
import 'package:shaty/features/doctor/data/models/article_model.dart';
import '../../../core/utils/helpers/helpers.dart';
import '../../../shared/common/post_details_screen.dart';
import 'package:shaty/core/extensions/localization_extension.dart';

class PostsSection extends StatelessWidget {
  const PostsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleCubit, ArticleState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          Helpers.showToast(message: state.successMessage!);
          context.read<ArticleCubit>().clearMessages();
        } else if (state.failureMessage != null) {
          Helpers.showToast(message: state.failureMessage!);
          context.read<ArticleCubit>().clearMessages();
        }
      },
      builder: (context, state) {
        final List<ArticleModel> articles = state.articles.toList();
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              // ✅ حالة: لا توجد مقالات
              if (articles.isEmpty && !state.isLoading) {
                return const Center(child: Text("لا توجد مقالات حالياً"));
              }
              if (index == 0) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    context.loc.new_post,
                    style: const TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }

              final articleIndex = index - 1;

              // ✅ حالة: مؤشر التحميل (عند تحميل الصفحة الأولى أو التالية)
              if (state.isLoading && articles.isEmpty) {
                return const Center(child: LinearProgressIndicator());
              }

              // ✅ حالة: مؤشر التحميل (عند تحميل الصفحة التالية)
              if (state.isLoading && index == articles.length + 1) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (articleIndex >= articles.length)
                return const SizedBox(); // حماية إضافية عشان لما يعمل سكرول بسرعة ما يصيرأكبر من articles.length + 1
              final article = articles[articleIndex];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      // Header
                      Row(
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
                                Text(
                                  article.doctor.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  article.doctor.email,
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

                      // Post Text
                      Text(article.subject,
                          style: const TextStyle(fontSize: 16)),

                      if (article.img != null) ...[
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            article.img!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 200,
                                color: Colors.grey[300],
                                alignment: Alignment.center,
                                child: const Icon(Icons.broken_image, size: 48),
                              );
                            },
                          ),
                        ),
                      ],

                      const SizedBox(height: 16),

                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PostAction(
                            icon: article.articleInfo.isLiked ? Icons.favorite : Icons.favorite_border,
                            label: '${article.articleInfo.numLikes}',
                            iconColor: article.articleInfo.isLiked ? Colors.red : Colors.grey[700], // ✅ تمرير اللون
                            onPressed: () {
                              context.read<ArticleCubit>().likeArticle(article.id);
                            },
                          ),

                          PostAction(
                            icon: Icons.comment_outlined,
                            label: '${article.articleInfo.numComments}',//context.loc.comment
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PostDetailsScreen(
                                    postContent: article.subject, articleId: article.id,
                                  ),
                                ),
                              );
                            },
                          ),
                          PostAction(
                            icon: Icons.share_outlined,
                            label:'',// context.loc.share
                            onPressed: () {
                              // يمكنك استخدام share_plus هنا لاحقًا
                            },
                          ),
                          PostAction(
                            icon: Icons.bookmark_border,
                            label:'',// context.loc.save
                            onPressed: () {
                              //TODO context.read<ArticleCubit>().bookmarkArticle(article.id);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: articles.length + 1 + (state.isLoading ? 1 : 0), // state.isLoading ? articles.length + 2 : articles.length + 1,
          ),
        );
      },
    );
  }
}

// ✅ 1. تحديث PostAction widget
class PostAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? iconColor; // إضافة iconColor parameter

  const PostAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.iconColor, // إضافة هذا في constructor
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(
              icon,
              size: 22,
              color: iconColor ?? Colors.grey[700] // ✅ استخدام iconColor هنا
          ),
          const SizedBox(width: 6),
          Text(
              label,
              style: TextStyle(color: Colors.grey[700])
          ),
        ],
      ),
    );
  }
}


