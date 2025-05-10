import 'package:flutter/material.dart';
import 'package:shaty/core/constants/app_colors.dart';

import '../../core/utils/helpers/storage_helper.dart';
class ShowAlertDialog extends StatelessWidget {
  final String title;
  final String action;
  final String? icon;
  final VoidCallback onConfirmed;

  const ShowAlertDialog({super.key, required this.title, required this.action,  this.icon, required this.onConfirmed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,textAlign: TextAlign.center,),
           const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: (){
                   onConfirmed();
                },
                child: Row(
                  children: [
                    if(icon != null)
                      Image.asset(icon!,height: 24,width: 24,),
                    Text(
                      action,
                      style: TextStyle(color: AppColors.secondaryColor),
                    ),
                  ],
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red)),
              ),
              ),
              const SizedBox(width: 10,),
              Expanded(child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor:
                  WidgetStateProperty.all(Colors.grey.shade300),
                ),
                child: const Text(
                  'إلغاء',
                  style: TextStyle(color: Colors.black),
                ),
              ),),


            ],
          ),


        ],
      ),
    );
  }
}
