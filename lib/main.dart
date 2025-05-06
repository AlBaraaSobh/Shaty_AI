import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shaty/core/network/api_consumer.dart';
import 'package:shaty/core/network/dio_consumer.dart';
import 'package:shaty/features/auth/cubit/patient_register_cubit.dart';
import 'package:shaty/features/auth/screen/change_password_screen.dart';
import 'package:shaty/features/auth/screen/login_screen.dart';
import 'package:shaty/features/auth/screen/rest_password_screen.dart';
import 'package:shaty/features/auth/screen/verification_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shaty/features/doctor/screen/bottom_navigation_screen.dart';
import 'package:shaty/features/doctor/screen/doctor_home_screen.dart';
import 'package:shaty/features/patient/widget/patient_bottom_nav_bar.dart';
import 'features/auth/cubit/doctor_register_cubit.dart';
import 'features/auth/screen/sign_in_screen.dart';


void main() {
  final api = DioConsumer(Dio());

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => PatientRegisterCubit(api)),
    BlocProvider(create: (_) => DoctorRegisterCubit(api)),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: '/login_screen',
      routes: {
        '/login_screen': (context)=> const LoginScreen(),
        '/sign_in_screen': (context)=> const SignInScreen(),
        '/rest_password_screen': (context)=> const RestPasswordScreen(),
        '/verification_screen': (context)=> const VerificationScreen(),
        '/change_password_screen': (context)=> const ChangePasswordScreen(),
        '/doctor_home_screen': (context)=> const DoctorHomeScreen(),
        '/bottom_navigation_screen': (context)=> const BottomNavigationScreen(),
        '/patient_bottom_nav_bar': (context)=> const PatientBottomNavBar(),
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales:const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: const Locale('ar'),
    );

  }
}

