import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shaty/core/constants/app_colors.dart';

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

  static void handleSuccess(BuildContext context, String message) {
     hideLoadingDialog(context);
     showToast(message: message);
    Navigator.pushNamed(context, '/patient_bottom_nav_bar');
  }

  static void handleFailure(BuildContext context, String error) {
    hideLoadingDialog(context); //في حال حذفتها بتصير مشلكة انو لو صار خطا بضل يحمل وما بيرجع
    showToast(message: error);
    print('the error is : $error');
  }
}