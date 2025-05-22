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
          Helpers.showToast(message : state.failureMessage!);
        }      },
      builder: (context, state) {
        final List<ArticleModel> articles = state.articles.toList();
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
              itemCount: articles.length,
              separatorBuilder: (_, __) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                final article = articles[index];
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
                                      fontWeight: FontWeight.bold,
                                    ),
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

                        /// Post Text
                        Text(
                         article.subject,
                          style: const TextStyle(fontSize: 16),
                        ),

                        /// Post Image if available
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
                                  color: Colors.grey[300],
                                  height: 200,
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
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
                              icon: Icons.favorite_border,
                              label: 'إعجاب',
                              onPressed: () {
                                //TODO
                              },
                            ),
                            PostAction(
                              icon: Icons.comment_outlined,
                              label: 'تعليق',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PostDetailsScreen(
                                          postContent: article.subject,
                                        ),
                                  ),
                                );
                              },
                            ),
                            PostAction(
                              icon: Icons.share_outlined,
                              label: 'مشاركة',
                              onPressed: () {
                                //TODO
                              },
                            ),
                            PostAction(
                              icon: Icons.bookmark_border,
                              label: 'حفظ',
                              onPressed: () {
                                //TODO
                              },
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
      },
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
