import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../core/constants/app_colors.dart';


class PinCodeInput extends StatelessWidget {
  final void Function(String) onCompleted;

  const PinCodeInput({super.key, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      onCompleted: onCompleted,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 50,
        fieldWidth: 48,
        activeFillColor: AppColors.primaryColor.withOpacity(0.1),
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        inactiveColor: Colors.grey,
        selectedColor: AppColors.primaryColor,
        activeColor: AppColors.primaryColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      onChanged: (value) {},
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // ✅ توزيع متساوي دون فراغات كبيرة

    );
  }
}
