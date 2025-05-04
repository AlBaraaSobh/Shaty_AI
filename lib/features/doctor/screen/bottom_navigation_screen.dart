import 'package:flutter/material.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'doctor_home_screen.dart';
import 'doctor_notifications_screen.dart';
import 'doctor_profile_screen.dart';
import 'doctor_setting_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0 ;
  final List<Widget>_screens = [
    const DoctorHomeScreen(),
    const DoctorProfileScreen(),
    const DoctorNotificationsScreen(),
    const DoctorSettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
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
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            iconSize: 30,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
            ],
          ),
        ),
      ),
    );
  }
}
