import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/localization/localization_extension.dart';
import 'package:shaty/core/utils/helpers/helpers.dart';
import 'package:shaty/features/doctor/data/models/article_model.dart';
import '../../../../shared/common/post_details_screen.dart';
import '../../../shared/widgets/show_alert_Dialog.dart';
import '../../shared/settings/cubit/is_saved_cubit.dart';
import '../cubit/article_cubit.dart';
import '../cubit/article_state.dart';
import '../cubit/doctor_profile_cubit.dart';
import '../cubit/doctor_profile_state.dart';
import '../screen/doctor_profile_screen.dart';
import 'create_post_bottom_sheet.dart';

class ArticleCard extends StatelessWidget {
  final ArticleModel article;

  const ArticleCard({super.key, required this.article});
  bool _isInsideDoctorProfileScreen(BuildContext context) {
    return context.findAncestorWidgetOfExactType<DoctorProfileScreen>() != null;
  }
  void _updateDoctorProfileCubitIfNeeded(BuildContext context, ArticleModel updatedArticle) {
    if (_isInsideDoctorProfileScreen(context)) {
      context.read<DoctorProfileCubit>().updateSingleArticle(updatedArticle);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95), // خلفية بيضاء شفافة قليلاً
          borderRadius: BorderRadius.circular(20), // زوايا أكثر دائرية لنعومة التصميم
          boxShadow: [
            // ظل ناعم لإضافة عمق للكارد
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ],
          border: Border.all(color: Colors.grey.shade200), // إطار فاتح جداً
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 14),
            Text(
              article.subject,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
            if (article.img != null) ...[
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  article.img!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 18),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    String fixImageUrl(String url) {
      if (url.contains('127.0.0.1')) {
        return url.replaceFirst('127.0.0.1', '10.0.2.2');
      }
      return url;
    }
    return Row(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundImage: article.doctor.img != null && article.doctor.img!.isNotEmpty
              ? NetworkImage(fixImageUrl(article.doctor.img!))
              : const AssetImage('images/doctor.png') as ImageProvider,
          backgroundColor: Colors.transparent,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.doctor.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                article.doctor.email,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
          builder: (context, state) {
            final currentDoctorId = state.doctor?.id;

            if (currentDoctorId != null && currentDoctorId == article.doctor.id) {
              return PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'edit') {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (_) => CreatePostBottomSheet(article: article),
                    );

                  } else if (value == 'delete') {
                    _showDeleteConfirmationDialog(context, article.id);
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => ShowAlertDialog(
                    //     title: 'هل أنت متأكد من الحذف؟',
                    //     action: context.loc.delete,
                    //     onConfirmed: () {
                    //       context.read<ArticleCubit>().deleteArticle(article.id);
                    //       Navigator.pop(context);
                    //     },
                    //   ),
                    // );
                  }
                },
                itemBuilder: (context) => [
                   PopupMenuItem(value: 'edit', child: Text( context.loc.edit, )),
                  PopupMenuItem(value: 'delete', child: Text(context.loc.delete)),
                ],
                icon: const Icon(Icons.more_horiz, color: Colors.grey),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _PostAction(
          icon: article.articleInfo.isLiked ? Icons.favorite : Icons.favorite_border,
          label: '${article.articleInfo.numLikes}',
          iconColor: article.articleInfo.isLiked ? Colors.red : Colors.grey[700],
          onPressed: () {
            //context.read<ArticleCubit>().likeArticle(article.id);
            final updatedInfo = article.articleInfo.copyWith(
              isLiked: !article.articleInfo.isLiked,
              numLikes: article.articleInfo.isLiked
                  ? article.articleInfo.numLikes - 1
                  : article.articleInfo.numLikes + 1,
            );
            final updatedArticle = article.copyWith(articleInfo: updatedInfo);
            _updateDoctorProfileCubitIfNeeded(context, updatedArticle);
            context.read<ArticleCubit>().likeArticle(article.id);
          },
        ),
        _PostAction(
          icon: Icons.comment_outlined,
          label: '${article.articleInfo.numComments}',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PostDetailsScreen(
                  postContent: article.subject,
                  articleId: article.id,
                ),
              ),
            );
          },
        ),
        _PostAction(
          icon: Icons.share_outlined,
          label: '',
          onPressed: () {
            Helpers.shareTextAndImage(
              context: context,
              text: article.subject,
              imageUrl: article.img,
            );
          },
        ),
        _PostAction(
          icon: article.articleInfo.isSaved ? Icons.bookmark : Icons.bookmark_border,
          label: '',
          onPressed: (){
          //  context.read<IsSavedCubit>().toggleSaveArticle(article.id);
            final isSavedCubit = context.read<IsSavedCubit>();
            final articleCubit = context.read<ArticleCubit>();

            isSavedCubit.toggleSaveArticle(article.id);
            articleCubit.toggleLocalSaveStatus(article.id);

            final updatedArticle = article.copyWith(
              articleInfo: article.articleInfo.copyWith(
                isSaved: !article.articleInfo.isSaved,
              ),
            );

            if (_isInsideDoctorProfileScreen(context)) {
              context.read<DoctorProfileCubit>().updateSingleArticle(updatedArticle);
            }

          },
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (dialogContext) => ShowAlertDialog(
        title: 'هل أنت متأكد من الحذف؟',
        action: 'حذف',
        onConfirmed: () async {
          // إغلاق الديالوج أولاً
          Navigator.of(dialogContext).pop();

          // إظهار loading indicator
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Center(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('جاري الحذف...'),
                    ],
                  ),
                ),
              ),
            ),
          );

          try {
            await context.read<ArticleCubit>().deleteArticle(id);
            // إغلاق loading dialog
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          } catch (e) {
            // إغلاق loading dialog
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            // إظهار رسالة خطأ
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('حدث خطأ أثناء الحذف'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );

  }
}

class _PostAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? iconColor;

  const _PostAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          children: [
            Icon(icon, size: 24, color: iconColor ?? Colors.grey[700]),
            if (label.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(label, style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w500)),
            ],
          ],
        ),
      ),
    );
  }

}
