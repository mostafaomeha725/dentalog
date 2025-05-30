import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorCard extends StatelessWidget {
  final Map doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    // بيانات user التفصيلية لو موجودة
    final user = doctor['user'] ?? {};
    final speciality = doctor['speciality'] ?? {};

    // fallback بيانات doctor المبسطة
    final name = user['name'] ?? doctor['name'] ?? 'Unknown';
    final phone = user['phone'] ?? doctor['phone'] ?? 'N/A';
    final specialityName = speciality['name'] ?? doctor['speciality_name'] ?? 'Speciality';
    final imageUrl = (user['image'] ?? doctor['image']) != null
        ? 'https://your-base-url.com/${user['image'] ?? doctor['image']}'
        : null;

    final schedules = doctor['schedules'] ?? [];
    final rating = num.tryParse(doctor['average_rating']?.toString() ?? '')?.round() ?? 0;

    // دالة للحصول على الوقت بشكل آمن
    String getFormattedTime(Map schedule) {
      final startTime = schedule['start_time']?.toString() ?? '';
      return startTime.length >= 16 ? startTime.substring(11, 16) : 'N/A';
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة الطبيب والتوافر
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        width: 92,
                        height: 85,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.person, size: 85),
                      )
                    : const Icon(Icons.person, size: 85),
              ),
              const SizedBox(height: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Next Available",
                      style: TextStyles.bold13w500.copyWith(color: const Color(0xff134FA2))),
                  Text(
                    schedules.isNotEmpty ? getFormattedTime(schedules[0]) : 'N/A',
                    style: TextStyles.bold12w500.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 12),

          // معلومات الطبيب
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyles.bold18w500),
                Text(
                  specialityName,
                  style: TextStyles.bold13w400.copyWith(color: const Color(0xff134FA2)),
                ),
                Text(
                  phone,
                  style: TextStyles.bold12w300.copyWith(color: Colors.grey),
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff134FA2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.kDoctorInfoView, extra: doctor);
                    },
                    child: Text(
                      "Book Now",
                      style: TextStyles.bold12w500.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
