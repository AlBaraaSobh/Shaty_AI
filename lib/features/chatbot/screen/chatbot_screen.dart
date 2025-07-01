import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/core/constants/app_colors.dart';
import 'package:shaty/features/chatbot/cubit/chatbot_cubit.dart';
import 'package:shaty/features/chatbot/cubit/chatbot_state.dart';
import 'package:shaty/features/chatbot/data/repositories/chatbot_repository.dart';
import 'package:dio/dio.dart';

import '../widget/typing_indicator.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return BlocProvider(
      create: (_) => ChatbotCubit(ChatbotRepository(Dio())),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المساعد الصحي'),
        ),
        body: BlocBuilder<ChatbotCubit, ChatbotState>(
          builder: (context, state) {
            final cubit = context.read<ChatbotCubit>();

            return Column(
              children: [
                Expanded(
                  child: state.messages.isEmpty && !state.isLoading
                      ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // صورة أو أيقونة طبية
                          Icon(
                            Icons.health_and_safety_outlined,
                            size: 120,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'مرحباً! يمكنك البدء بكتابة أسئلتك الصحية هنا👨‍🔬',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                      : ListView.builder(
                    controller: ScrollController(),
                    padding: const EdgeInsets.all(12),
                    reverse: true,
                    itemCount: state.messages.length + (state.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == 0 && state.isLoading) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const TypingIndicator(),
                          ),
                        );
                      }

                      final actualIndex = state.isLoading ? index - 1 : index;
                      final message = state.messages.reversed.toList()[actualIndex];
                      final isUser = message.containsKey('user');
                      final content = isUser ? message['user']! : message['bot']!;
                      return Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: isUser
                            ? _buildUserBubble(content, context)
                            : _buildBotBubbleAnimated(content, context),
                      );


                      // return Align(
                      //   alignment:
                      //   isUser ? Alignment.centerRight : Alignment.centerLeft,
                      //   child: Container(
                      //     margin: const EdgeInsets.symmetric(vertical: 6),
                      //     padding: const EdgeInsets.all(14),
                      //     constraints: BoxConstraints(
                      //       maxWidth: MediaQuery.of(context).size.width * 0.75,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       color: isUser
                      //           ? Theme.of(context).colorScheme.primary
                      //           : Theme.of(context).colorScheme.surfaceVariant,
                      //       borderRadius: BorderRadius.circular(16),
                      //     ),
                      //     child: Text(
                      //       content,
                      //       style: TextStyle(
                      //         color: isUser ? Colors.white : Colors.black87,
                      //         fontSize: 15,
                      //       ),
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                ),

                if (state.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      state.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // تحسين شكل حقل النص
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'اكتب سؤالك الصحي هنا...',
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (_) => _sendMessage(context, cubit, _controller),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        radius: 26,
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () => _sendMessage(context, cubit, _controller),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
  Widget _buildUserBubble(String text, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
    );
  }
  Widget _buildBotBubbleAnimated(String text, BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 0, end: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 15,
          ),
        ),
      ),
    );
  }


  void _sendMessage(
      BuildContext context,
      ChatbotCubit cubit,
      TextEditingController controller,
      ) {
    final message = controller.text.trim();
    if (message.isNotEmpty) {
      cubit.sendMessage(message);
      controller.clear();
    }
  }
}
