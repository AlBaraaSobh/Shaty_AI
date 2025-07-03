import 'package:flutter/material.dart';
import 'package:shaty/features/patient/widget/patient_header.dart';

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
                  PatientHeader(),
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
               //   PostsSection(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
