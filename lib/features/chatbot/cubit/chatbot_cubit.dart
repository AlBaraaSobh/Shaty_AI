import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaty/features/chatbot/data/repositories/chatbot_repository.dart';
import 'chatbot_state.dart';

class ChatbotCubit extends Cubit<ChatbotState> {
  final ChatbotRepository repository;

  ChatbotCubit(this.repository) : super(const ChatbotState());

  Future<void> sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    final updatedMessages = [
      ...state.messages,
      {"user": userMessage},
    ];
    emit(state.copyWith(
      messages: updatedMessages,
      isLoading: true,
      errorMessage: null,
    ));

    try {
      final botReply = await repository.getBotReply(userMessage);
      final newMessages = [
        ...updatedMessages,
        {"bot": botReply},
      ];
      emit(state.copyWith(
        messages: newMessages,
        isLoading: false,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void clearMessages() {
    emit(state.copyWith(messages: [], errorMessage: null));
  }
}
