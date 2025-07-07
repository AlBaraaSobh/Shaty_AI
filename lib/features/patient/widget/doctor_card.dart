import 'package:flutter/material.dart';
import '../data/models/doctor_specialty_model.dart';

class DoctorCard extends StatelessWidget {
  final DoctorSpecialtyModel doctor;
  final bool isFollowed;
  final String buttonText;
  final Color buttonColor;
  final VoidCallback? onButtonPressed;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.isFollowed,
    required this.buttonText,
    required this.buttonColor,
    this.onButtonPressed,
  });

  String fixImageUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    if (url.contains('127.0.0.1')) {
      return url.replaceFirst('127.0.0.1', '10.0.2.2');
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = fixImageUrl(doctor.image.trim());
    final isNetwork = imageUrl.startsWith('http') || imageUrl.contains('/storage/') || imageUrl.contains('10.0.2.2');
    final placeholder =  const AssetImage('images/doctor.png');
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: isNetwork
                  ? NetworkImage(imageUrl)
                  : placeholder,
              onBackgroundImageError: (_, __) {},
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.email,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(90, 36),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onButtonPressed,
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
