class ErrorModel {
  final String? message;
  final Map<String, List<String>>? errors;

  ErrorModel({this.message, this.errors});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json['message'],
      errors: (json['errors'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, List<String>.from(value),
        ),
      ),
    );
  }

  String get firstErrorMessage {
    if (errors != null && errors!.isNotEmpty) {
      final firstList = errors!.values.first;
      if (firstList.isNotEmpty) {
        return firstList.first;
      }
    }
    return message ?? 'حدث خطأ غير متوقع.';
  }
}
