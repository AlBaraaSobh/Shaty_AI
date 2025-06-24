import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/features/doctor/cubit/article_cubit.dart';
import 'package:shaty/features/doctor/cubit/article_state.dart';
import 'package:shaty/features/doctor/data/models/article_model.dart';
import '../../../core/utils/helpers/helpers.dart';
import '../../../shared/common/post_details_screen.dart';
import 'package:shaty/core/extensions/localization_extension.dart';

import 'article_card.dart';

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
                    style: const  TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                      letterSpacing: 0.5,
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ArticleCard(
                  article: article,

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


