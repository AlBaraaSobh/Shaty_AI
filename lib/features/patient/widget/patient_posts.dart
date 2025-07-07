import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/core/localization/localization_extension.dart';
import 'package:shaty/features/doctor/data/models/article_model.dart';
import 'package:shaty/features/patient/cubit/patient_article_cubit.dart';

import '../../doctor/cubit/article_state.dart';
import '../../doctor/widget/article_card.dart';

class PatientPosts extends StatelessWidget {
  const PatientPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientArticleCubit, ArticleState>(
      builder: (context, state) {
        final List<ArticleModel> articles = state.articles;
        print('Articles count: ${state.articles.length}');
        print('📦 Articles in UI: ${state.articles.length}');

        if (state.isLoading && articles.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (articles.isEmpty && !state.isLoading) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: Text("لا توجد مقالات حالياً")),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    context.loc.new_post,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                );
              }

              final articleIndex = index - 1;

              if (articleIndex >= articles.length) return const SizedBox();

              final article = articles[articleIndex];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ArticleCard(article: article),
              );
            },
            childCount: articles.length + 1,
          ),
        );
      },
    );
  }
}
