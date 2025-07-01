import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shaty/core/localization/locale_cubit.dart';
import 'package:shaty/core/network/dio_consumer.dart';
import 'package:shaty/features/auth/cubit/login_cubit.dart';
import 'package:shaty/features/auth/cubit/patient_register_cubit.dart';
import 'package:shaty/features/auth/data/repositories/doctor_register_repository.dart';
import 'package:shaty/features/auth/data/repositories/login_repository.dart';
import 'package:shaty/features/auth/data/repositories/patient_register_repository.dart';
import 'package:shaty/features/auth/screen/change_password_screen.dart';
import 'package:shaty/features/auth/screen/login_screen.dart';
import 'package:shaty/features/auth/screen/rest_password_screen.dart';
import 'package:shaty/features/auth/screen/verification_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shaty/features/doctor/cubit/article_cubit.dart';
import 'package:shaty/features/doctor/cubit/comment_cubit.dart';
import 'package:shaty/features/doctor/cubit/doctor_profile_cubit.dart';
import 'package:shaty/features/doctor/cubit/tips_cubit.dart';
import 'package:shaty/features/doctor/data/repositories/article_repository.dart';
import 'package:shaty/features/doctor/data/repositories/comment_repository.dart';
import 'package:shaty/features/doctor/data/repositories/doctor_profile_repository.dart';
import 'package:shaty/features/doctor/data/repositories/tips_repository.dart';
import 'package:shaty/features/doctor/screen/bottom_navigation_screen.dart';
import 'package:shaty/features/doctor/screen/doctor_home_screen.dart';
import 'package:shaty/features/doctor/widget/view_tips.dart';
import 'package:shaty/features/patient/widget/patient_bottom_nav_bar.dart';
import 'package:shaty/features/shared/settings/cubit/change_password_cubit.dart';
import 'package:shaty/features/shared/settings/cubit/edit_profile_cubit.dart';
import 'package:shaty/features/shared/settings/data/repositories/change_password_repository.dart';
import 'package:shaty/features/shared/settings/data/repositories/edit_profile_repository.dart';

import 'core/utils/helpers/storage_helper.dart';
import 'features/auth/cubit/doctor_register_cubit.dart';
import 'features/auth/screen/sign_in_screen.dart';
import 'features/doctor/data/repositories/notification_repository.dart';

import 'package:shaty/features/doctor/cubit/notification_cubit.dart';

import 'features/shared/settings/cubit/is_saved_cubit.dart';
import 'features/shared/settings/cubit/saved_cubit.dart';
import 'features/shared/settings/data/repositories/saved_repository.dart';
import 'features/shared/settings/screen/edit_doctor_profile_screen.dart';
import 'features/shared/settings/screen/is_saved_repository.dart';
import 'features/shared/settings/screen/saved_article.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final api = DioConsumer(Dio());

  final token = await StorageHelper.getToken();
  final userType = await StorageHelper.getUserType();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                PatientRegisterCubit(PatientRegisterRepository(api))),
        BlocProvider(
            create: (_) => DoctorRegisterCubit(DoctorRegisterRepository(api))),
        BlocProvider(create: (_) => LoginCubit(LoginRepository(api))),
        BlocProvider(create: (_) => TipsCubit(TipsRepository(api))),
        BlocProvider(create: (_) => ArticleCubit(ArticleRepository(api))),
        BlocProvider(create: (_) => CommentCubit(CommentRepository(api))),
        BlocProvider(
            create: (_) => DoctorProfileCubit(DoctorProfileRepository(api))),
        BlocProvider(create: (_) => SavedCubit(SavedRepository(api))),
        BlocProvider(create: (_) => IsSavedCubit(IsSavedRepository(api))),
        BlocProvider(
            create: (_) => NotificationCubit(NotificationRepository(api))),
        BlocProvider(
            create: (_) => ChangePasswordCubit(ChangePasswordRepository(api))),
        BlocProvider(
          create: (context) =>
              EditProfileCubit(
                EditProfileRepository(api),
                context.read<DoctorProfileCubit>(),
              ),
        ),
        BlocProvider(create: (_) => LocaleCubit()),

      ],
      child: MyApp(
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          locale: locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          routes: {
            '/login_screen': (context) => const LoginScreen(),
            '/sign_in_screen': (context) => const SignInScreen(),
            '/rest_password_screen': (context) => const RestPasswordScreen(),
            '/verification_screen': (context) => const VerificationScreen(),
            '/change_password_screen': (
                context) => const ChangePasswordScreen(),
            '/doctor_home_screen': (context) => const DoctorHomeScreen(),
            '/bottom_navigation_screen': (context) =>
            const BottomNavigationScreen(),
            '/patient_bottom_nav_bar': (context) => const PatientBottomNavBar(),
            '/view_tips': (context) => const ViewTips(),
            '/saved_article': (context) => const SavedArticle(),
            '/edit_doctor_profile_screen': (context) =>
            const EditDoctorProfileScreen(),
          },
        );
      },
    );
  }
}
