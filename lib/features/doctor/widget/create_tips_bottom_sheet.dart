import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/extensions/localization_extension.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/primary_button .dart';
import '../cubit/tips_cubit.dart';


class CreateTipsBottomSheet extends StatefulWidget {
  final int? tipId;
  final String? initialTip;

  const CreateTipsBottomSheet({super.key, this.initialTip, this.tipId});

  @override
  State<CreateTipsBottomSheet> createState() => _CreateTipsBottomSheetState();
}


class _CreateTipsBottomSheetState extends State<CreateTipsBottomSheet> {
  late final TextEditingController _tipController;

  @override
  void initState() {
    super.initState();
    _tipController = TextEditingController(text: widget.initialTip ?? '');
  }

  @override
  void dispose() {
  _tipController.dispose();
    super.dispose();
  }
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
                controller: _tipController,
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
              PrimaryButton(
                label:widget.tipId == null ?context.loc.post : context.loc.edit_daily_tips,
                onPressed: () {
                  final text = _tipController.text.trim();
                  if (text.isNotEmpty) {
                    if (widget.tipId == null) {
                      // حالة الإضافة
                      BlocProvider.of<TipsCubit>(context).addTips(tips: text);
                    } else {
                      // حالة التعديل
                      BlocProvider.of<TipsCubit>(context).updateTip(widget.tipId!.toString(), text);
                    }

                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
