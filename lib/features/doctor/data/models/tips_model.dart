class TipsModel {
  final int id;

  final String advice;

  TipsModel({required this.id, required this.advice});

  factory TipsModel.fromJson(Map<String, dynamic> json) {
    print("test from Json😉👩‍💻 ${json}");
    return TipsModel(id: json['id'], advice: json['advice']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id ,
      'advice': advice,
    };
  }
}
