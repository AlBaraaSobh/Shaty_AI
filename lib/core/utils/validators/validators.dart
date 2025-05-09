class Validators {

  static String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) return 'البريد مطلوب';
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value.trim())) return 'بريد إلكتروني غير صالح';
  return null;
  }

  static String? validatePassword(String? value) {
  if (value == null || value.trim().isEmpty) return 'كلمة المرور مطلوبة';
  if (value.length < 8) return 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';
  return null;
  }

//***************


  // // تحقق من صحة البريد الإلكتروني
  // static bool isValidEmail(String email) {
  //   final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
  //   return emailRegex.hasMatch(email.trim());
  // }
  //
  // //  للبريد الإلكتروني
  // static String? emailValidator(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'يرجى إدخال البريد الإلكتروني';
  //   }
  //   if (!isValidEmail(value)) {
  //     return 'البريد الإلكتروني غير صالح';
  //   }
  //   return null;
  // }
  //
  // // تحقق من قوة كلمة المرور
  // static bool isStrongPassword(String password) {
  //   final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
  //   return passwordRegex.hasMatch(password.trim());
  // }
  //
  // //  لكلمة المرور
  // static String? passwordValidator(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'يرجى إدخال كلمة المرور';
  //   }
  //   if (!isStrongPassword(value)) {
  //     return 'كلمة المرور ضعيفة (يجب أن تحتوي على حرف كبير وصغير ورقم ورمز خاص وألا تقل عن 8 حروف)';
  //   }
  //   return null;
  // }
  //
  //  لتأكيد كلمة المرور
  static String? confirmPasswordValidator(String? value, String originalPassword) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى تأكيد كلمة المرور';
    }
    if (value.trim() != originalPassword.trim()) {
      return 'كلمتا المرور غير متطابقتين';
    }
    return null;
  }

  //  للاسم
  static String? nameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال الاسم';
    }
    if (value.trim().length < 3) {
      return 'يجب أن يحتوي الاسم على 3 أحرف على الأقل';
    }
    return null;
  }

  // Validator للرقم الوظيفي المكون من 6 أرقام
  static String? jobNumberValidator(String? value) {
    final jobNumberRegex = RegExp(r'^\d{6}$');
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال الرقم الوظيفي';
    }
    if (!jobNumberRegex.hasMatch(value.trim())) {
      return 'يجب أن يتكون الرقم الوظيفي من 6 أرقام';
    }
    return null;
  }
}
