import 'package:flutter/material.dart';

import '../widget/tips_section.dart';
import '../widget/DoctorsPost.dart';
import '../widget/home_doctor_header.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

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
            ],
          ),
        ),
      ),
    );
  }
}
