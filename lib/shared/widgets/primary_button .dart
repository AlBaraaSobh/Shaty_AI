import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
class  PrimaryButton  extends StatelessWidget {
  final String label ;
  final VoidCallback ? onPressed;
  final bool isLoading;

  const PrimaryButton ({super.key, required this.label, required this.onPressed,this.isLoading = false});

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

      onPressed:isLoading ? null : onPressed,
      child: isLoading ?  const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      ): Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
