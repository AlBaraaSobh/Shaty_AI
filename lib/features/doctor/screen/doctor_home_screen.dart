import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/tips_cubit.dart';
import '../widget/tips_section.dart';
import '../widget/DoctorsPost.dart';
import '../widget/home_doctor_header.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  bool _isFirstTime = true;

  @override
  void initState() {
     super.initState();
    // if (_isFirstTime) {
    //
    // }

     context.read<TipsCubit>().getTips();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              HomeDoctorHeader(),
              SizedBox(
                height: 25,
              ),
              TipsSection(),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 15,
              ),
              PostsSection(),
            ],
          ),
        ),
      ),
    );
  }
}