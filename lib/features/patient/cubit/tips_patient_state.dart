import '../../doctor/data/models/tips_model.dart';

class TipsPatientState {
  final bool isLoading;
  final List<TipsModel> tips;
  final String? error;

  TipsPatientState({
    this.isLoading = false,
    this.tips = const [],
    this.error,
  });

  TipsPatientState copyWith({
    bool? isLoading,
    List<TipsModel>? tips,
    String? error,
  }) {
    return TipsPatientState(
      isLoading: isLoading ?? this.isLoading,
      tips: tips ?? this.tips,
      error: error,
    );
  }
}
