import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shaty/core/network/api_consumer.dart';
import 'package:shaty/core/network/dio_consumer.dart';
import 'package:shaty/features/auth/cubit/login_cubit.dart';
import 'package:shaty/features/auth/cubit/patient_register_cubit.dart';
import 'package:shaty/features/auth/screen/change_password_screen.dart';
import 'package:shaty/features/auth/screen/login_screen.dart';
import 'package:shaty/features/auth/screen/rest_password_screen.dart';
import 'package:shaty/features/auth/screen/verification_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shaty/features/doctor/cubit/article_cubit.dart';
import 'package:shaty/features/doctor/cubit/tips_cubit.dart';
import 'package:shaty/features/doctor/data/repositories/article_repository.dart';
import 'package:shaty/features/doctor/data/repositories/tips_repository.dart';
import 'package:shaty/features/doctor/screen/bottom_navigation_screen.dart';
import 'package:shaty/features/doctor/screen/doctor_home_screen.dart';
import 'package:shaty/features/doctor/widget/view_tips.dart';
import 'package:shaty/features/patient/widget/patient_bottom_nav_bar.dart';
import 'core/utils/helpers/storage_helper.dart';
import 'features/auth/cubit/doctor_register_cubit.dart';
import 'features/auth/screen/sign_in_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final api = DioConsumer(Dio());

  final token = await StorageHelper.getToken();
  final userType = await StorageHelper.getUserType();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => PatientRegisterCubit(api)),
    BlocProvider(create: (_) => DoctorRegisterCubit(api)),
    BlocProvider(create: (_) => LoginCubit(api)),
    BlocProvider(create: (_) => TipsCubit(TipsRepository(api))),
    BlocProvider(create: (_) => ArticleCubit(ArticleRepository(api))),
  ], child:  MyApp(
    initialRoute: token == null
        ? '/login_screen'
        : userType == 'doctor'
        ? '/bottom_navigation_screen'
        : '/patient_bottom_nav_bar',
  )));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        '/login_screen': (context)=> const LoginScreen(),
        '/sign_in_screen': (context)=> const SignInScreen(),
        '/rest_password_screen': (context)=> const RestPasswordScreen(),
        '/verification_screen': (context)=> const VerificationScreen(),
        '/change_password_screen': (context)=> const ChangePasswordScreen(),
        '/doctor_home_screen': (context)=> const DoctorHomeScreen(),
        '/bottom_navigation_screen': (context)=> const BottomNavigationScreen(),
        '/patient_bottom_nav_bar': (context)=> const PatientBottomNavBar(),
        '/view_tips': (context)=> const ViewTips(),
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

