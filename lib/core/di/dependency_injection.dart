import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'package:shaty/core/localization/locale_cubit.dart';
import 'package:shaty/core/network/dio_consumer.dart';

// Auth
import 'package:shaty/features/auth/cubit/login_cubit.dart';
import 'package:shaty/features/auth/cubit/patient_register_cubit.dart';
import 'package:shaty/features/auth/cubit/doctor_register_cubit.dart';
import 'package:shaty/features/auth/cubit/reset_password_cubit.dart';
import 'package:shaty/features/auth/data/repositories/doctor_register_repository.dart';
import 'package:shaty/features/auth/data/repositories/login_repository.dart';
import 'package:shaty/features/auth/data/repositories/patient_register_repository.dart';
import 'package:shaty/features/auth/data/repositories/reset_password_repository.dart';

// Doctor
import 'package:shaty/features/doctor/cubit/article_cubit.dart';
import 'package:shaty/features/doctor/cubit/comment_cubit.dart';
import 'package:shaty/features/doctor/cubit/doctor_profile_cubit.dart';
import 'package:shaty/features/doctor/cubit/tips_cubit.dart';
import 'package:shaty/features/doctor/cubit/notification_cubit.dart';
import 'package:shaty/features/doctor/data/repositories/article_repository.dart';
import 'package:shaty/features/doctor/data/repositories/comment_repository.dart';
import 'package:shaty/features/doctor/data/repositories/doctor_profile_repository.dart';
import 'package:shaty/features/doctor/data/repositories/tips_repository.dart';
import 'package:shaty/features/doctor/data/repositories/notification_repository.dart';

// Patient
import 'package:shaty/features/patient/cubit/patient_article_cubit.dart';
import 'package:shaty/features/patient/cubit/patient_doctors_cubit.dart';
import 'package:shaty/features/patient/cubit/patient_profile_cubit.dart';
import 'package:shaty/features/patient/cubit/tips_patient_cubit.dart';
import 'package:shaty/features/patient/data/repositories/patient_doctors_repository.dart';
import 'package:shaty/features/patient/data/repositories/patient_profile_repository.dart';
import 'package:shaty/features/patient/data/repositories/tips_patient_repository.dart';

// Shared
import 'package:shaty/features/shared/settings/cubit/change_password_cubit.dart';
import 'package:shaty/features/shared/settings/cubit/edit_profile_cubit.dart';
import 'package:shaty/features/shared/settings/cubit/is_saved_cubit.dart';
import 'package:shaty/features/shared/settings/cubit/saved_cubit.dart';
import 'package:shaty/features/shared/settings/data/repositories/change_password_repository.dart';
import 'package:shaty/features/shared/settings/data/repositories/edit_profile_repository.dart';
import 'package:shaty/features/shared/settings/data/repositories/saved_repository.dart';
import '../../features/shared/settings/screen/is_saved_repository.dart';

/// Service Locator for Dependency Injection
final GetIt sl = GetIt.instance;

class ServiceLocator {
  ServiceLocator._();

  static Future<void> init() async {
    try {
      debugPrint('🔧 Initializing dependencies...');
      await _initializeCore();
      await _initializeRepositories();
      await _initializeCubits();
      debugPrint('✅ All dependencies initialized successfully');
    } catch (e, stackTrace) {
      debugPrint('❌ Error initializing dependencies: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  static Future<void> reset() async {
    await sl.reset();
    debugPrint('🔄 Dependencies reset');
  }

  static bool get isInitialized => sl.isRegistered<DioConsumer>();

  /// Core dependencies
  static Future<void> _initializeCore() async {
    debugPrint('  📡 Initializing network dependencies...');
    final dio = Dio();
    _configureDio(dio);

    sl.registerLazySingleton<Dio>(() => dio);
    sl.registerLazySingleton<DioConsumer>(() => DioConsumer(sl<Dio>()));
    debugPrint('  ✅ Network dependencies initialized');
  }

  static void _configureDio(Dio dio) {
    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: false,
          error: true,
          logPrint: (obj) => debugPrint('DIO: $obj'),
        ),
      );
    }
  }

  /// Repositories
  static Future<void> _initializeRepositories() async {
    debugPrint('  🗂️  Initializing repositories...');
    final api = sl<DioConsumer>();

    // Auth
    sl.registerLazySingleton<LoginRepository>(() => LoginRepository(api));
    sl.registerLazySingleton<PatientRegisterRepository>(() => PatientRegisterRepository(api));
    sl.registerLazySingleton<DoctorRegisterRepository>(() => DoctorRegisterRepository(api));
    sl.registerLazySingleton<ResetPasswordRepository>(() => ResetPasswordRepository(api));

    // Doctor
    sl.registerLazySingleton<TipsRepository>(() => TipsRepository(api));
    sl.registerLazySingleton<ArticleRepository>(() => ArticleRepository(api));
    sl.registerLazySingleton<CommentRepository>(() => CommentRepository(api));
    sl.registerLazySingleton<DoctorProfileRepository>(() => DoctorProfileRepository(api));
    sl.registerLazySingleton<NotificationRepository>(() => NotificationRepository(api));

    // Patient
    sl.registerLazySingleton<PatientDoctorsRepository>(() => PatientDoctorsRepository(api));
    sl.registerLazySingleton<TipsPatientRepository>(() => TipsPatientRepository(api));
    sl.registerLazySingleton<PatientProfileRepository>(() => PatientProfileRepository(api));

    // Shared
    sl.registerLazySingleton<SavedRepository>(() => SavedRepository(api));
    sl.registerLazySingleton<IsSavedRepository>(() => IsSavedRepository(api));
    sl.registerLazySingleton<ChangePasswordRepository>(() => ChangePasswordRepository(api));
    sl.registerLazySingleton<EditProfileRepository>(() => EditProfileRepository(api));

    debugPrint('  ✅ Repositories initialized');
  }

  /// Cubits
  static Future<void> _initializeCubits() async {
    debugPrint('  🧊 Initializing cubits...');

    // Locale
    sl.registerLazySingleton<LocaleCubit>(() => LocaleCubit());

    _registerAuthCubits();
    _registerDoctorCubits();
    _registerPatientCubits();
    _registerSharedCubits();

    debugPrint('  ✅ Cubits initialized');
  }

  static void _registerAuthCubits() {
    sl.registerFactory<LoginCubit>(() => LoginCubit(sl<LoginRepository>()));
    sl.registerFactory<PatientRegisterCubit>(() => PatientRegisterCubit(sl<PatientRegisterRepository>()));
    sl.registerFactory<DoctorRegisterCubit>(() => DoctorRegisterCubit(sl<DoctorRegisterRepository>()));
    sl.registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(sl<ResetPasswordRepository>()));
  }

  static void _registerDoctorCubits() {
    sl.registerFactory<TipsCubit>(() => TipsCubit(sl<TipsRepository>()));
    sl.registerFactory<ArticleCubit>(() => ArticleCubit(sl<ArticleRepository>()));
    sl.registerFactory<CommentCubit>(() => CommentCubit(sl<CommentRepository>()));
    sl.registerFactory<DoctorProfileCubit>(() => DoctorProfileCubit(sl<DoctorProfileRepository>()));
    sl.registerFactory<NotificationCubit>(() => NotificationCubit(sl<NotificationRepository>()));
  }

  static void _registerPatientCubits() {
    sl.registerFactory<PatientDoctorsCubit>(() => PatientDoctorsCubit(sl<PatientDoctorsRepository>()));
    sl.registerFactory<TipsPatientCubit>(() => TipsPatientCubit(sl<TipsPatientRepository>()));
    sl.registerFactory<PatientArticleCubit>(() => PatientArticleCubit(sl<ArticleRepository>()));
    sl.registerFactory<PatientProfileCubit>(() => PatientProfileCubit(sl<PatientProfileRepository>()));
  }

  static void _registerSharedCubits() {
    sl.registerFactory<SavedCubit>(() => SavedCubit(sl<SavedRepository>()));
    sl.registerFactory<IsSavedCubit>(() => IsSavedCubit(sl<IsSavedRepository>()));
    sl.registerFactory<ChangePasswordCubit>(() => ChangePasswordCubit(sl<ChangePasswordRepository>()));
    sl.registerFactoryParam<EditProfileCubit, DoctorProfileCubit, void>(
          (doctorProfileCubit, _) => EditProfileCubit(
        sl<EditProfileRepository>(),
        doctorProfileCubit,
      ),
    );
  }
}

extension ServiceLocatorX on GetIt {
  T getDependency<T extends Object>() {
    if (!isRegistered<T>()) {
      throw Exception('❌ Dependency $T is not registered. Did you call ServiceLocator.init()?');
    }
    return get<T>();
  }

  bool hasDependency<T extends Object>() => isRegistered<T>();
}
