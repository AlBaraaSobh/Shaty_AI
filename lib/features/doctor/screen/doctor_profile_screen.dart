
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/utils/helpers/helpers.dart';

import 'package:shaty/features/doctor/widget/ProfileStats.dart';
import 'package:shaty/features/doctor/widget/biography_doctor.dart';

import '../cubit/doctor_profile_cubit.dart';
import '../cubit/doctor_profile_state.dart';
import '../cubit/tips_cubit.dart';

import '../cubit/tips_state.dart';
import '../widget/doctor_posts_section.dart';
import '../widget/profile_header.dart';
import '../widget/show_tips.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final doctorCubit = context.read<DoctorProfileCubit>();
      await doctorCubit.getDoctorProfile();
      await doctorCubit.getDoctorArticles();
      await doctorCubit.getDoctorInfo();
      await context.read<TipsCubit>().getTips();
    });
  }


  Future<void> _onRefresh() async {
    final doctorCubit = context.read<DoctorProfileCubit>();
    await doctorCubit.getDoctorProfile(forceRefresh: true);
    await doctorCubit.getDoctorArticles(forceRefresh: true);
    await context.read<TipsCubit>().getTips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DoctorProfileCubit, DoctorProfileState>(
            listener: (context, state) {
              final doctorCubit = context.read<DoctorProfileCubit>();
              if (state.failureMessage != null) {
                Helpers.showToast(message: state.failureMessage!);
                doctorCubit.clearMessages();
              }
              if (state.successMessage != null) {
                Helpers.showToast(message: state.successMessage!);
                doctorCubit.clearMessages();

              }
            },
          ),
          BlocListener<TipsCubit, TipsState>(
            listener: (context, state) {
              final tipsCubit = context.read<TipsCubit>();
            if (state.failureMessage != null) {
              Helpers.showToast(message: state.failureMessage!);
              tipsCubit.clearMessages();
            }
            if (state.successMessage != null) {
              Helpers.showToast(message: state.successMessage!);
              tipsCubit.clearMessages();
            }
            },
          ),
        ],
        child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
          builder: (context, state) {
            final isLoading = state.isLoading && state.doctor == null;

            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          ProfileHeader(),
                          const SizedBox(height: 10),
                          ProfileStats(),
                          const SizedBox(height: 10),
                          BiographyDoctor(),
                          Divider(thickness: 2, color: Colors.grey[300]),
                          const SizedBox(height: 8),
                          ShowTips(),
                          const SizedBox(height: 8),
                          Divider(thickness: 2, color: Colors.grey[300]),
                          const SizedBox(height: 8),
                          DoctorPostsSection(),
                        ],
                      ),
                    ),
                  ),
                ),

                if (isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
