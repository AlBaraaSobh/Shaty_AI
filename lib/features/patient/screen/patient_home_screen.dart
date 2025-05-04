import 'package:flutter/material.dart';

import '../../doctor/widget/DoctorsPost.dart';
import '../../doctor/widget/home_doctor_header.dart';
import '../../doctor/widget/tips_section.dart';
import '../widget/patient_tips.dart';
class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  HomeDoctorHeader(),
                  SizedBox(
                    height: 25,
                  ),
                  PatientTips(),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  PostsSection(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
