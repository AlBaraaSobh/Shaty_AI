import 'package:flutter/material.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/core/extensions/localization_extension.dart';

import '../../../shared/widgets/primary_button .dart';

class CreatePostBottomSheet extends StatelessWidget {
  const CreatePostBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 40,
          ),
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
                  context.loc.create_new_post,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
            ],
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
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(Icons.image),),
          ],),
          SizedBox(height: 20,),
          TextFormField(
            maxLines: 8,
            decoration: InputDecoration(
              hintText: 'ماذا تريد أن تشارك؟',
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
    );
  }
}
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     IconButton(
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//         icon: const Icon(Icons.arrow_back_ios,size: 20,)),
//      // SizedBox(width: 40,),
//     Expanded(
//       child: Center(
//         child: Text(
//           context.loc.create_new_post,
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//             color: AppColors.secondaryColor,
//           ),
//         ),
//       ),
//     ),
//
//   ],
// ),