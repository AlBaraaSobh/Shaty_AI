import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/core/utils/helpers/storage_helper.dart';
import 'package:shaty/features/auth/cubit/login_cubit.dart';
import 'package:shaty/features/doctor/cubit/comment_cubit.dart';
import 'package:shaty/features/doctor/cubit/doctor_profile_cubit.dart';
import 'package:shaty/features/doctor/cubit/notification_cubit.dart';
import 'package:shaty/features/doctor/cubit/tips_cubit.dart';

import '../../../features/doctor/cubit/article_cubit.dart';
import '../../../features/doctor/widget/create_tips_bottom_sheet.dart';

class Helpers {
  static void showToast({
    required String message,
    Color backgroundColor = AppColors.primaryColor,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showLoadingDialog(BuildContext context, {String? text}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Text(text ?? 'جاري التحميل...'),
          ],
        ),
      ),
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  //أفضل خيار عام لضمان عدم ظهور خطأ عند محاولة إغلاق شاشة غير موجودةNavigator.canPop
  static void handleLoading(BuildContext context) {
    showLoadingDialog(context);
  }

  static void handleSuccess(BuildContext context, String message,{String? route}) {
     hideLoadingDialog(context);
     showToast(message: message);
     if (route != null) {
       Navigator.pushNamed(context, route);
     }  }




  static void handleFailure(BuildContext context, String error) {
    hideLoadingDialog(context); //في حال حذفتها بتصير مشلكة انو لو صار خطا بضل يحمل وما بيرجع
    showToast(message: error);
    print('the error is : $error');
  }

  static Future<void> logout(BuildContext context) async {
    await StorageHelper.clearToken();
    // تنظيف الكيوبتات
    context.read<ArticleCubit>().clear();
    context.read<TipsCubit>().clear();
    context.read<CommentCubit>().clear();
    context.read<DoctorProfileCubit>().clear();
    context.read<NotificationCubit>().clear();
    context.read<LoginCubit>().clear();



    // إزالة جميع الصفحات السابقة  والانتقال إلى صفحة تسجيل الدخول
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/login_screen',
          (route) => false,
    );
  }

  static void showCreateTipsBottomSheet(BuildContext context,{String? initialTip, int? tipId}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CreateTipsBottomSheet(initialTip: initialTip, tipId: tipId),

    );
  }

  //

  static Future<void> shareTextAndImage({
    required BuildContext context,
    required String text,
    String? imageUrl,
  }) async {
    try {
      if (imageUrl != null && imageUrl.isNotEmpty) {
        final dio = Dio();
        final response = await dio.get<List<int>>(
          imageUrl,
          options: Options(responseType: ResponseType.bytes),
        );

        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/shared_image.jpg');
        await file.writeAsBytes(response.data!);

        await Share.shareXFiles(
          [XFile(file.path)],
          text: text,
        );
      } else {
        await Share.share(text);
      }
    } catch (e, stackTrace) {
      print('❌ خطأ المشاركة: $e');
      print('📄 StackTrace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ حدث خطأ أثناء المشاركة')),
      );
    }

  }



}