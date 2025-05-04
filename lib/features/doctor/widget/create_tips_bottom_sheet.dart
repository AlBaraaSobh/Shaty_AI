import 'package:flutter/material.dart';
import 'package:shaty/core/extensions/localization_extension.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/primary_button .dart';


class CreateTipsBottomSheet extends StatelessWidget {
  const CreateTipsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                      )),
               //    const SizedBox(width: 10,),
                  Text(
                    context.loc.add_daily_tips,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12,),
              Row(
                children: [
                  Icon(Icons.post_add,size: 20,),
                  SizedBox(width: 12,),
                  Text(context.loc.topic,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                ],
              ),
              SizedBox(height: 10,),
              TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: '"اشرب 8 أكواب ماء يوميًا للحفاظ على ترطيب جسمك"',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
              SizedBox(height: 40,),
              PrimaryButton(label: context.loc.post,
                onPressed: () {
                  ///TODO
                },),
            ],
          ),
        ),
      ),
    );
  }
}
