import 'package:flutter/material.dart';

import '../widget/doctor_card.dart';
class PatientDoctorsScreen extends StatefulWidget {
  const PatientDoctorsScreen({super.key});

  @override
  State<PatientDoctorsScreen> createState() => _PatientDoctorsScreenState();
}

class _PatientDoctorsScreenState extends State<PatientDoctorsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String> specialties = [
    'أمراض القلب والشرايين',
    'الجراحة العامة',
    'الأمراض الباطنية',
    'الأمراض الجلدية',
    'الأمراض العصبية',
    'الأمراض النفسية',
    'الأمراض النسائية والولادة',
    'الأطفال',
    'الأورام',
  ];

  Map<int, List<Map<String, String>>> doctorsBySpecialty = {
    0: [
      {
        'name': 'د. أحمد يوسف',
        'email': 'ahmed@gmail.com',
      },
      {
        'name': 'د. سارة علي',
        'email': 'sara@gmail.com',
      },
    ],
    4: [
      {
        'name': 'محمد أشرف',
        'email': 'alishafee@gmail.com',
      },
      {
        'name': 'Sdfgh',
        'email': 'Sss@gmail.com',
      },
    ],
  };

  List<Map<String, String>> followedDoctors = [];
  int? selectedSpecialtyIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  bool isDoctorFollowed(Map<String, String> doctor) {
    return followedDoctors.any((d) => d['email'] == doctor['email']);
  }

  void followDoctor(Map<String, String> doctor) {
    setState(() {
      if (!isDoctorFollowed(doctor)) {
        followedDoctors.add(doctor);
      }
    });
  }

  void unfollowDoctor(Map<String, String> doctor) {
    setState(() {
      followedDoctors.removeWhere((d) => d['email'] == doctor['email']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التخصصات'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'التخصصات'),
            Tab(text: 'متابعين'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // التخصصات
          ListView.builder(
            itemCount: specialties.length,
            itemBuilder: (context, index) {
              bool isSelected = selectedSpecialtyIndex == index;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('${index + 1}. ${specialties[index]}'),
                    trailing: Icon(
                      isSelected ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_left,
                    ),
                    onTap: () {
                      setState(() {
                        selectedSpecialtyIndex = isSelected ? null : index;
                      });
                    },
                  ),
                  if (isSelected && doctorsBySpecialty.containsKey(index))
                    Column(
                      children: doctorsBySpecialty[index]!
                          .map(
                            (doctor) => DoctorCard(
                          doctor: doctor,
                          isFollowed: isDoctorFollowed(doctor),
                          buttonText: isDoctorFollowed(doctor) ? 'متابع' : 'متابعة',
                          buttonColor: Colors.blue,
                          onButtonPressed: isDoctorFollowed(doctor)
                              ? null
                              : () => followDoctor(doctor),
                        ),
                      )
                          .toList(),
                    )
                ],
              );
            },
          ),
          // المتابعين
          followedDoctors.isEmpty
              ? const Center(child: Text('لم تقم بمتابعة أي طبيب بعد'))
              : ListView.builder(
            itemCount: followedDoctors.length,
            itemBuilder: (context, index) {
              return DoctorCard(
                doctor: followedDoctors[index],
                isFollowed: true,
                buttonText: 'إلغاء المتابعة',
                buttonColor: Colors.red,
                onButtonPressed: () => unfollowDoctor(followedDoctors[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}