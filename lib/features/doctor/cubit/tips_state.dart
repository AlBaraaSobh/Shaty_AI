import '../data/models/tips_model.dart';

class TipsState {
  final bool isLoading;
  final String? failureMessage;
  final String? successMessage;
  final List<TipsModel> tips;


  TipsState({this.isLoading = false, this.failureMessage, this.successMessage,this.tips = const []});

  factory TipsState.initial() =>  TipsState();

  TipsState copyWith({
    bool? isLoading,
    String? failureMessage,
    String? successMessage,
    final List<TipsModel>? tips
  }) {
    return TipsState(
      isLoading: isLoading ?? this.isLoading,
      failureMessage: failureMessage,
      successMessage: successMessage,
      tips: tips ?? this.tips,

    );
  }
}
