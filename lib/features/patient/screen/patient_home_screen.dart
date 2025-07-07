import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/patient/cubit/patient_article_cubit.dart';
import 'package:shaty/features/patient/cubit/tips_patient_cubit.dart';
import 'package:shaty/features/patient/widget/patient_header.dart';
import 'package:shaty/features/patient/widget/patient_posts.dart';
import '../widget/patient_tips.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  @override
  void initState() {
    final tipsCubit = context.read<TipsPatientCubit>();
    final postCubit = context.read<PatientArticleCubit>();

    if (tipsCubit.state.tips.isEmpty) {
      tipsCubit.fetchTodayAdvice();
    }
    if (postCubit.state.articles.isEmpty) {
      postCubit.getPaginatedArticles(1);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 🟢 رأس الصفحة
            SliverToBoxAdapter(
              child: Column(
                children: [
                  PatientHeader(),
                  SizedBox(height: 25),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: PatientTips(),
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Divider(thickness: 1),
                  SizedBox(height: 15),
                ],
              ),
            ),

            PatientPosts(),
          ],
        ),
      ),
    );
  }
}
