import 'package:flutter/material.dart';
import 'package:shaty/core/extensions/localization_extension.dart';
import '../../core/constants/app_colors.dart';
import '../../core/enums/user_role_enum.dart';

class RoleSelector extends StatelessWidget {
  final UserRole selectedRole;
  final ValueChanged<UserRole> onChanged;

  const RoleSelector({
    super.key,
    required this.selectedRole,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<UserRole>(
        segments: [
          ButtonSegment(
            value: UserRole.patient,
            label: Text(context.loc.sign_in_patient_title),
          ),
          ButtonSegment(
            value: UserRole.doctor,
            label: Text(context.loc.sign_in_doctor_title),
          ),
        ],
        selected: {selectedRole},
        onSelectionChanged: (Set<UserRole> newSelection) {
          onChanged(newSelection.first);
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors.primaryColor;
            }
            return Colors.white;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Color(0xFFEDEDEE);
            }
            return Colors.black;
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
    );
  }
}
