import 'package:flutter/material.dart';
import 'package:shaty/features/patient/screen/patient_doctors_screen.dart';
import 'package:shaty/features/patient/screen/patient_home_screen.dart';
import 'package:shaty/features/patient/screen/patient_notifications_screen.dart';
import 'package:shaty/features/patient/screen/patient_settings_screen.dart';

import '../../../core/constants/app_colors.dart';

class PatientBottomNavBar extends StatefulWidget {
  const PatientBottomNavBar({super.key});

  @override
  State<PatientBottomNavBar> createState() => _PatientBottomNavBarState();
}

class _PatientBottomNavBarState extends State<PatientBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    PatientHomeScreen(),
    PatientDoctorsScreen(),
    PatientNotificationsScreen(),
    PatientSettingsScreen(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // استخدمت IndexedStack للحفاظ على حالة كل شاشة أثناء التنقل
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(2),
            topLeft: Radius.circular(2),
          ),
          child: BottomNavigationBar(
            elevation: 5,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            iconSize: 30,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: '',),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
            ],
          ),
        ),
      ),
    );
  }
}
