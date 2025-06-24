class DoctorNotification {
  final String type;
  final String title;
  final String description;
  final String createdAt;

  DoctorNotification({
    required this.type,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory DoctorNotification.fromJson(Map<String, dynamic> json) {
    return DoctorNotification(
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
