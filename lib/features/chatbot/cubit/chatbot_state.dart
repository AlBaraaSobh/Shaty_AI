
class ChatbotState {
  final List<Map<String, String>> messages;
  final bool isLoading;
  final String? errorMessage;

  const ChatbotState({
    this.messages = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ChatbotState copyWith({
    List<Map<String, String>>? messages,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ChatbotState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
