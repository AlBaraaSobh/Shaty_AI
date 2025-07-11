import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/localization/localization_extension.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../doctor/data/models/article_model.dart';
import '../../../doctor/widget/article_card.dart';
import '../cubit/saved_cubit.dart';
import '../cubit/saved_state.dart';

class SavedArticle extends StatefulWidget {
  const SavedArticle({super.key});

  @override
  State<SavedArticle> createState() => _SavedArticleState();
}

class _SavedArticleState extends State<SavedArticle> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<SavedCubit>().getSavedArticles();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 &&
          !context.read<SavedCubit>().state.isLoadingMore &&
          context.read<SavedCubit>().state.hasMore) {
        context.read<SavedCubit>().getSavedArticles();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(context.loc.archives,style: TextStyle(color: AppColors.primaryColor),
        ),
      ),
      body: BlocBuilder<SavedCubit, SavedState>(
        builder: (context, state) {
          if (state.isLoading && state.articles.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.failureMessage != null) {
            return Center(child: Text(state.failureMessage!));
          }

          if (state.articles.isEmpty) {
            return  Center(child: Text(context.loc.no_saved_article));
          }

          return ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.all(8),
            itemCount: state.hasMore ? state.articles.length + 1 : state.articles.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              if (index < state.articles.length) {
                final ArticleModel article = state.articles[index];
                return ArticleCard(article: article);
              } else {
                if (state.isLoadingMore) {
                  return const Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }
            },
          );
        },
      ),
    );
  }
}
