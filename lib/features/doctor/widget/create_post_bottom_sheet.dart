import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/core/extensions/localization_extension.dart';

import '../../../core/utils/helpers/helpers.dart';
import '../../../shared/widgets/primary_button .dart';
import '../cubit/article_cubit.dart';
import '../cubit/article_state.dart';
import '../data/models/article_model.dart';

class CreatePostBottomSheet extends StatefulWidget {
  final ArticleModel? article; // null => إنشاء، غير null => تعديل
  const CreatePostBottomSheet({super.key, this.article});
  @override
  State<CreatePostBottomSheet> createState() => _CreatePostBottomSheetState();
}

class _CreatePostBottomSheetState extends State<CreatePostBottomSheet> {
  final _titleController = TextEditingController();
  final _subjectController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.article != null) {
      _titleController.text = widget.article!.title ?? '';
      _subjectController.text = widget.article!.subject ?? '';
      // ممكن تخزن الصورة أيضًا إذا كانت محفوظة عندك محليًا
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleCubit, ArticleState>(
  listener: (context, state) {
    if (state.successMessage != null) {
      Navigator.of(context).pop(); // إغلاق الـ BottomSheet
      Helpers.showToast(message: state.successMessage!);
    } else if (state.failureMessage != null) {
      Helpers.showToast(message: state.failureMessage!);
    }
  },
  builder: (context, state) {
    return Padding(
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 40,
          ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios,size: 20,),
                  ),
                ),
                Center(
                  child: Text(
                      widget.article == null
                          ? context.loc.create_new_post
                          : context.loc.edit,
        
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
        
            Row(children: [
              const Icon(Icons.post_add),
              const SizedBox(width: 12,),
              Text(
               context.loc.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.secondaryColor,
                ),
              ),
              Spacer(),
              IconButton(onPressed: (){
                _pickImage();
        
              }, icon: Icon(Icons.image),),
            ],),
            TextFormField(
              controller: _titleController,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: context.loc.hint_title ,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 12,),
            Row(children: [
              const Icon(Icons.post_add),
              const SizedBox(width: 12,),
              Text(
                context.loc.topic,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.secondaryColor,
                ),
              ),
        
            ],),
            TextFormField(
              controller: _subjectController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: context.loc.hint_subject,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 12),
            if (_selectedImage != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _selectedImage!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            SizedBox(height: 40,),
            PrimaryButton(
              label: context.loc.post,
              onPressed: () {
                if (!state.isLoading) {
                  _handlePost();
                }
              }
            ),
            if (state.isLoading) const CircularProgressIndicator(),
        
        
          ],
        ),
      ),
    );
  },
);
  }
  // void _handlePost() {
  //   final title = _titleController.text.trim();
  //   final subject = _subjectController.text.trim();
  //   if (title.isEmpty || subject.isEmpty) {
  //     Helpers.showToast(message: 'يرجى ملء جميع الحقول');
  //     return;
  //   }
  //
  //   context.read<ArticleCubit>().createArticle(
  //     title: title,
  //     subject: subject,
  //     img: _selectedImage,
  //   );
  // }
  void _handlePost() {
    final title = _titleController.text.trim();
    final subject = _subjectController.text.trim();
    if (title.isEmpty || subject.isEmpty) {
      Helpers.showToast(message: 'يرجى ملء جميع الحقول');
      return;
    }

    if (widget.article == null) {
      // إنشاء مقال جديد
      context.read<ArticleCubit>().createArticle(
        title: title,
        subject: subject,
        img: _selectedImage,
      );
    } else {
      // تعديل مقال موجود
      context.read<ArticleCubit>().updateArticle(
        id: widget.article!.id.toString(),
        title: title,
        subject: subject,
        img: _selectedImage, // أرسل null لو ما تغيرت الصورة
      );
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

}
