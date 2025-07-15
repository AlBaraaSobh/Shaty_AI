import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/patient/cubit/patient_article_cubit.dart';
import 'package:shaty/features/patient/cubit/tips_patient_cubit.dart';
import 'package:shaty/features/patient/widget/patient_header.dart';
import 'package:shaty/features/patient/widget/patient_posts.dart';
import '../../../core/constants/app_colors.dart';
import '../../chatbot/screen/chatbot_screen.dart';
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor, // أو استخدم AppColors.primaryLight
        tooltip: 'المساعد الصحي',
        onPressed:() {
          Navigator.of(context).push(
             MaterialPageRoute(builder: (_) =>  ChatbotScreen()),
          );
        },
        child:  const Icon(Icons.smart_toy_outlined, size: 28,color: Colors.white,),
      ),
      body: const SafeArea(
        child: CustomScrollView(
          slivers: [
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
