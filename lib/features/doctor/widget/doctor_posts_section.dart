import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/doctor/cubit/doctor_profile_cubit.dart';
import 'package:shaty/features/doctor/cubit/doctor_profile_state.dart';

import 'article_card.dart';

class DoctorPostsSection extends StatelessWidget {
  const DoctorPostsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        final articles = state.articles;

        if (articles.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                "لا توجد مقالات للطبيب حالياً.",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: articles.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ArticleCard(article: articles[index]);
          },
        );
      },
    );
  }
}
