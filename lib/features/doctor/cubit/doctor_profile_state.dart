import '../data/models/article_model.dart';
import '../data/models/doctor_stats_model.dart';
import '../data/models/doctors_model.dart';

class DoctorProfileState {
  final bool isLoading;
  final String? failureMessage;
  final String? successMessage;
  final DoctorsModel? doctor;
  final DoctorStatsModel? info;
  final List<DoctorsModel> followers;
  final List<ArticleModel> articles;
  final int? deletedArticleId;
  final int tipsCount;

  DoctorProfileState({
    this.isLoading = false,
    this.failureMessage,
    this.successMessage,
    this.doctor,
    this.info,
    this.followers = const [],
    this.articles = const [],
    this.deletedArticleId,
    this.tipsCount = 0,
  });

  factory DoctorProfileState.initial() => DoctorProfileState();

  DoctorProfileState copyWith({
    bool? isLoading,
    String? failureMessage,
    String? successMessage,
    DoctorsModel? doctor,
    DoctorStatsModel? info,
    List<DoctorsModel>? followers,
    List<ArticleModel>? articles,
    int? deletedArticleId,
    int? tipsCount,
  }) {
    return DoctorProfileState(
      isLoading: isLoading ?? this.isLoading,
      failureMessage: failureMessage ?? this.failureMessage,
      successMessage: successMessage ?? this.successMessage,
      doctor: doctor ?? this.doctor,
      info: info ?? this.info,
      followers: followers ?? this.followers,
      articles: articles ?? this.articles,
      deletedArticleId: deletedArticleId ?? this.deletedArticleId,
      tipsCount: tipsCount ?? this.tipsCount,
    );
  }
}
