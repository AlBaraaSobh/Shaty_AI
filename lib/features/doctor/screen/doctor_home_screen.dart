import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';

import '../../../core/utils/helpers/helpers.dart';
import '../../chatbot/screen/chatbot_screen.dart';
import '../cubit/article_cubit.dart';
import '../cubit/article_state.dart';
import '../cubit/tips_cubit.dart';
import '../widget/tips_section.dart';
import '../widget/posts_section.dart';
import '../widget/home_doctor_header.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  late ScrollController _scrollController;
  int _currentPage = 1;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();

    final articleCubit = context.read<ArticleCubit>();
    final tipsCubit = context.read<TipsCubit>();

    tipsCubit.getTips();
    articleCubit.getPaginatedArticles(_currentPage);

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final cubit = context.read<ArticleCubit>();
    final state = cubit.state;

    if (!_isFetchingMore &&
        _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100 &&
        !state.isLoading &&
        _currentPage < state.lastPage) {
      _isFetchingMore = true;
      _currentPage++;
      cubit.getPaginatedArticles(_currentPage).then((_) => _isFetchingMore = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    _currentPage = 1;
    _isFetchingMore = false;
    await context.read<TipsCubit>().getTips();
    await context.read<ArticleCubit>().getPaginatedArticles(_currentPage);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor, // أو استخدم AppColors.primaryLight
        tooltip: 'المساعد الصحي',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ChatbotScreen()),
          );
        },
        child: const Icon(Icons.smart_toy_outlined, size: 28,color: Colors.white,),
      ),
      body: SafeArea(
        child: BlocListener<ArticleCubit, ArticleState>(
          listenWhen: (previous, current) =>
          previous.successMessage != current.successMessage ||
              previous.failureMessage != current.failureMessage,
          listener: (context, state) {
            if (state.successMessage != null) {
              Helpers.showToast(message: state.successMessage!);
              context.read<ArticleCubit>().clearMessages();
            }

            if (state.failureMessage != null) {
              Helpers.showToast(message: state.failureMessage!);
              context.read<ArticleCubit>().clearMessages();
            }
          },
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: const [
                SliverToBoxAdapter(child: HomeDoctorHeader()),
                SliverToBoxAdapter(child: SizedBox(height: 25)),
                SliverToBoxAdapter(child: TipsSection()),
                SliverToBoxAdapter(child: Divider(thickness: 1)),
                SliverToBoxAdapter(child: SizedBox(height: 15)),
                PostsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: RefreshIndicator(
//           onRefresh: _onRefresh,
//           child: CustomScrollView(
//             controller: _scrollController,
//             slivers: [
//               const SliverToBoxAdapter(child: HomeDoctorHeader()),
//               const SliverToBoxAdapter(child: SizedBox(height: 25)),
//               const SliverToBoxAdapter(child: TipsSection()),
//               const SliverToBoxAdapter(child: Divider(thickness: 1)),
//               const SliverToBoxAdapter(child: SizedBox(height: 15)),
//               const PostsSection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../cubit/article_cubit.dart';
// import '../cubit/tips_cubit.dart';
// import '../widget/tips_section.dart';
// import '../widget/posts_section.dart';
// import '../widget/home_doctor_header.dart';
//
// class DoctorHomeScreen extends StatefulWidget {
//   const DoctorHomeScreen({super.key});
//
//   @override
//   State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
// }
//
// class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
//   late ScrollController _scrollController;
//   int _currentPage = 1;
//   bool _isFetchingMore = false;
//
//   @override
//   void initState() {
//     super.initState();
//     //context.read<TipsCubit>().getTips();
//    // context.read<ArticleCubit>().getPaginatedArticles(_currentPage);
//
//     _scrollController = ScrollController()..addListener(_onScroll);
//     // _scrollController.addListener(_onScroll);
//   }
//
//   void _onScroll() {
//     final cubit = context.read<ArticleCubit>();
//     final state = cubit.state;
//
//     if (!_isFetchingMore &&
//         _scrollController.position.pixels >=
//             _scrollController.position.maxScrollExtent - 100 &&
//         !state.isLoading &&
//         _currentPage < state.lastPage) {
//       _isFetchingMore = true;
//       _currentPage++;
//       cubit.getPaginatedArticles(_currentPage).then((_) {
//         _isFetchingMore = false;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: RefreshIndicator(
//           onRefresh: () => _onRefresh(),
//           child: CustomScrollView(
//             controller: _scrollController,
//             slivers: [
//               SliverToBoxAdapter(child: HomeDoctorHeader()),
//               SliverToBoxAdapter(child: SizedBox(height: 25)),
//               SliverToBoxAdapter(child: TipsSection()),
//               SliverToBoxAdapter(child: Divider(thickness: 1)),
//               SliverToBoxAdapter(child: SizedBox(height: 15)),
//               PostsSection(),
//
//               ],
//           ),
//         ),
//       ),
//     );
//   }
//   Future<void> _onRefresh() async {
//     _currentPage = 1;
//     _isFetchingMore = false;
//     await context.read<TipsCubit>().getTips();
//     await context.read<ArticleCubit>().getPaginatedArticles(_currentPage);
//   }
//
 }
