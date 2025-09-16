import 'package:flutter/material.dart';

// Auth
import 'package:shaty/features/auth/screen/login_screen.dart';
import 'package:shaty/features/auth/screen/sign_in_screen.dart';
import 'package:shaty/features/auth/screen/rest_password_screen.dart';
import 'package:shaty/features/auth/screen/verification_screen.dart';
import 'package:shaty/features/auth/screen/change_password_screen.dart';

// Doctor
import 'package:shaty/features/doctor/screen/doctor_home_screen.dart';
import 'package:shaty/features/doctor/screen/bottom_navigation_screen.dart';
import 'package:shaty/features/doctor/widget/view_tips.dart';

// Patient
import 'package:shaty/features/patient/screen/patient_bottom_nav_bar.dart';
import 'package:shaty/features/patient/screen/edit_patient_profile_screen.dart';

// Shared
import 'package:shaty/features/shared/settings/screen/edit_doctor_profile_screen.dart';
import 'package:shaty/features/shared/settings/screen/saved_article.dart';

class AppRouter {
  // Route names
  static const String login = '/login';
  static const String signIn = '/sign-in';
  static const String resetPassword = '/reset-password';
  static const String verification = '/verification';
  static const String changePassword = '/change-password';

  static const String doctorHome = '/doctor-home';
  static const String doctorBottomNav = '/doctor-bottom-nav';
  static const String viewTips = '/view-tips';

  static const String patientHome = '/patient-home';
  static const String editPatientProfile = '/edit-patient-profile';

  static const String editDoctorProfile = '/edit-doctor-profile';
  static const String savedArticle = '/saved-article';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case resetPassword:
        return MaterialPageRoute(builder: (_) => const RestPasswordScreen());
      case verification:
        return MaterialPageRoute(builder: (_) => const VerificationScreen());
      case changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());

      case doctorHome:
        return MaterialPageRoute(builder: (_) => const DoctorHomeScreen());
      case doctorBottomNav:
        return MaterialPageRoute(builder: (_) => const BottomNavigationScreen());
      case viewTips:
        return MaterialPageRoute(builder: (_) => const ViewTips());

      case patientHome:
        return MaterialPageRoute(builder: (_) => const PatientBottomNavBar());
      case editPatientProfile:
        return MaterialPageRoute(builder: (_) => const EditPatientProfileScreen());

      case editDoctorProfile:
        return MaterialPageRoute(builder: (_) => const EditDoctorProfileScreen());
      case savedArticle:
        return MaterialPageRoute(builder: (_) => const SavedArticle());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Route not found")),
          ),
        );
    }
  }
}
