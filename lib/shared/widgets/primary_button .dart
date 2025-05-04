import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
class  PrimaryButton  extends StatelessWidget {
  final String label ;
  final VoidCallback onPressed;
  const PrimaryButton ({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
      ),

      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
