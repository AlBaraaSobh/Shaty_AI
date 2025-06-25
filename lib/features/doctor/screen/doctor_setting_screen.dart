import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/extensions/localization_extension.dart';
import 'package:shaty/core/utils/helpers/helpers.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/change_password_form.dart';
import '../../../shared/widgets/show_alert_Dialog.dart';
import '../../shared/settings/cubit/change_password_cubit.dart';
import '../../shared/settings/cubit/change_password_state.dart';
import '../widget/build_settings_tile.dart';
import '../widget/profile_setting_header.dart';

class DoctorSettingScreen extends StatefulWidget {
  const DoctorSettingScreen({super.key});

  @override
  State<DoctorSettingScreen> createState() => _DoctorSettingScreenState();
}

class _DoctorSettingScreenState extends State<DoctorSettingScreen> {
  bool isNotificationsEnabled = true;
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state.successMessage != null) {
          Navigator.pop(context);
          Helpers.showToast(message: state.successMessage!);
          context.read<ChangePasswordCubit>().clearMessages();
          oldPasswordController.clear();
          newPasswordController.clear();
          confirmPasswordController.clear();
        } else if (state.failureMessage != null) {
          Helpers.showToast(message: state.failureMessage!);
          context.read<ChangePasswordCubit>().clearMessages();
        }
      },
      child: Scaffold(
        body: Padding(
          padding:
          const EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const ProfileSettingHeader(),
                const Divider(color: Colors.grey, thickness: 0.5, height: 20),
                const SizedBox(height: 10),

                BuildSettingsTile(
                  icon: 'images/notifications_active.png',
                  title: context.loc.manage_notifications,
                  onTap: () => _showNotificationBottomSheet(context),
                ),
                const Divider(color: Colors.grey, thickness: 0.5, height: 20),

                BuildSettingsTile(
                  icon: 'images/archive.png',
                  title: context.loc.archives,
                  onTap: () => Navigator.pushNamed(context, '/saved_article'),
                ),
                const Divider(color: Colors.grey, thickness: 0.5, height: 20),

                BuildSettingsTile(
                  icon: 'images/security_safe.png',
                  title: context.loc.change_password,
                  onTap: () => _showChangePasswordBottomSheet(context),
                ),
                const Divider(color: Colors.grey, thickness: 0.5, height: 20),

                BuildSettingsTile(
                  icon: 'images/logout.png',
                  title: context.loc.logout,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ShowAlertDialog(
                        title: context.loc.logout_title,
                        action: context.loc.logout,
                        onConfirmed: () => Helpers.logout(context),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showNotificationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: SwitchListTile(
          title: const Text(
            'تفعيل الإشعارات',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          value: isNotificationsEnabled,
          activeColor: AppColors.primaryColor,
          onChanged: (value) {
            setState(() {
              isNotificationsEnabled = value;
            });
          },
        ),
      ),
    );
  }

  void _showChangePasswordBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: SingleChildScrollView(
          child: ChangePasswordForm(
            oldPasswordController: oldPasswordController,
            newPasswordController: newPasswordController,
            confirmPasswordController: confirmPasswordController,
            onConfirm: _handleConfirm,
          ),
        ),
      ),
    );
  }

  void _handleConfirm() {
    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      Helpers.showToast(message: context.loc.fill_all_fields);
      return;
    }

    if (newPassword != confirmPassword) {
      Helpers.showToast(message: context.loc.passwords_do_not_match);
      return;
    }

    context.read<ChangePasswordCubit>().changePassword(
      lastPassword: oldPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:shaty/core/extensions/localization_extension.dart';
// import 'package:shaty/core/utils/helpers/helpers.dart';
//
// import '../../../core/constants/app_colors.dart';
// import '../../../shared/widgets/change_password_form.dart';
// import '../../../shared/widgets/show_alert_Dialog.dart';
// import '../widget/build_settings_tile.dart';
// import '../widget/profile_setting_header.dart';
//
// class DoctorSettingScreen extends StatefulWidget {
//   const DoctorSettingScreen({super.key});
//
//   @override
//   State<DoctorSettingScreen> createState() => _DoctorSettingScreenState();
// }
//
// class _DoctorSettingScreenState extends State<DoctorSettingScreen> {
//   bool isNotificationsEnabled = true;
//
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//
//   @override
//   void dispose() {
//     newPasswordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding:
//             const EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const ProfileSettingHeader(),
//               const Divider(color: Colors.grey, thickness: 0.5, height: 20),
//               SizedBox(
//                 height: 10,
//               ),
//               BuildSettingsTile(
//                 icon: 'images/notifications_active.png',
//                 title: context.loc.manage_notifications,
//                 onTap: () {
//                   // TODO
//                   _showNotificationBottomSheet(context);
//
//                 },
//               ),
//               const Divider(color: Colors.grey, thickness: 0.5, height: 20),
//               BuildSettingsTile(
//                 icon: 'images/archive.png',
//                 title: context.loc.archives,
//                 onTap: () {
//                   //TODO
//                   Navigator.pushNamed(context, '/saved_article');
//
//                 },
//               ),
//               const Divider(color: Colors.grey, thickness: 0.5, height: 20),
//               BuildSettingsTile(
//                 icon: 'images/security_safe.png',
//                 title: context.loc.change_password,
//                 onTap: () {
//                   //TODO
//                   _showCreateTipsBottomSheet(context);
//                 },
//               ),
//               const Divider(color: Colors.grey, thickness: 0.5, height: 20),
//               BuildSettingsTile(
//                 icon: 'images/logout.png',
//                 title: context.loc.logout,
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => ShowAlertDialog(
//                       title: context.loc.logout_title,
//                       action: context.loc.logout,
//                       onConfirmed: () => Helpers.logout(context),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//
//
//   }
//   void _showNotificationBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => Padding(padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//         left: 20,
//         right: 20,
//         top: 20,
//       ),child:  SwitchListTile(
//         title: const Text(
//           'تفعيل الإشعارات',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//         value: isNotificationsEnabled,
//         activeColor: AppColors.primaryColor,
//         onChanged: (value) {
//           setState(() {
//             isNotificationsEnabled = value;
//
//           });
//
//         },
//       ),
//       ),);
//   }
//
//
//   void _showCreateTipsBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         builder: (context) => Padding(padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//           left: 20,
//           right: 20,
//           top: 20,
//         ),child:
//         SingleChildScrollView(
//           child: ChangePasswordForm(
//             newPasswordController: newPasswordController,
//             confirmPasswordController: confirmPasswordController,
//             onConfirm:  _handleConfirm,
//           ),
//         )
//           ,),);
//   }
//
//   void _handleConfirm() {
//     final newPassword = newPasswordController.text.trim();
//     final confirmPassword = confirmPasswordController.text.trim();
//
//     if (newPassword.isEmpty || confirmPassword.isEmpty) {
//       Helpers.showToast(message: 'context.loc.fill_all_fields');
//       return;
//     }
//
//     if (newPassword != confirmPassword) {
//       Helpers.showToast(message: 'context.loc.passwords_do_not_match');
//       return;
//     }
//
//     // TODO: ربط بـ Cubit
//     print('New password confirmed');
//   }
// }
//**********
// ListView(
//   shrinkWrap: true,
//   physics: NeverScrollableScrollPhysics(),
//   children: [
//     ListTile(
//       leading: Icon(Icons.notifications, color: Colors.blue),
//       title: Text('إدارة الإشعارات'),
//       trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
//     ),
//     ListTile(
//       leading: Icon(Icons.lock, color: Colors.purple),
//       title: Text('تغيير كلمة المرور'),
//       trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
//     ),
//     ListTile(
//       leading: Icon(Icons.logout, color: Colors.red),
//       title: Text('تسجيل الخروج'),
//       trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
//     ),
//   ],
// )