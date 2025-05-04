import 'package:flutter/material.dart';
import 'package:shaty/features/doctor/widget/ProfileStats.dart';
import 'package:shaty/features/doctor/widget/biography_doctor.dart';

import '../widget/DoctorsPost.dart';
import '../widget/profile_header.dart';
import '../widget/show_tips.dart';



class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
          child: Column(
            children: [
              ProfileHeader(),
              SizedBox(
                height: 10,
              ),
              ProfileStats(),
              SizedBox(
                height: 10,
              ),
              BiographyDoctor(),

              Divider(thickness: 2, color: Colors.grey[300]),
              SizedBox(
                height: 8,
              ),
              ShowTips(),
              SizedBox(
                height: 8,
              ),
              Divider(thickness: 2, color: Colors.grey[300]),
              SizedBox(
                height: 8,
              ),
              PostsSection(),
              //DoctorPostSection(),

            ],
          ),
        ),
      ),
    );
  }
}

