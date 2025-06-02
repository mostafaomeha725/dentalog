import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorCard extends StatelessWidget {
  final Map doctor;
final bool istrue;
  const DoctorCard({super.key, required this.doctor,  this.istrue=true});

  @override
  Widget build(BuildContext context) {
    final user = doctor['user'] ?? {};
    final speciality = doctor['speciality'] ?? {};

    final name = user['name'] ?? doctor['name'] ?? 'Unknown';
    final phone = user['phone'] ?? doctor['phone'] ?? 'N/A';
    final specialityName = speciality['name'] ?? doctor['speciality_name'] ?? 'Speciality';

    final imageUrl = _normalizeImageUrl(user['image'] ?? doctor['image']);

    final schedules = doctor['schedules'] ?? [];
    final rating = num.tryParse(doctor['average_rating']?.toString() ?? '')?.round() ?? 0;

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
                child: Image(
                  image: _getImageProvider(imageUrl),
                  width: 92,
                  height: 85,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 6),
          istrue?    Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Next Available",
                    style: TextStyles.bold13w500.copyWith(color: const Color(0xff134FA2)),
                  ),
                  Text(
                    schedules.isNotEmpty ? getFormattedTime(schedules[0]) : 'N/A',
                    style: TextStyles.bold12w500.copyWith(color: Colors.grey),
                  ),
                ],
              ):SizedBox(),
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

  /// دالة لإرجاع صورة من الشبكة أو صورة افتراضية
  static ImageProvider _getImageProvider(String? url) {
    if (url != null && url.trim().isNotEmpty) {
      return NetworkImage(url);
    } else {
      return const AssetImage(Assets.assetsProfileAvater);
    }
  }

  /// دالة لتنظيف رابط الصورة
  static String? _normalizeImageUrl(dynamic rawUrl) {
    if (rawUrl == null) return null;

    String url = rawUrl.toString().trim();

    // إزالة تكرار النطاق إذا موجود
    url = url.replaceAll(RegExp(r'^https?://.*dentalog/https?://'), 'https://');

    if (!url.startsWith('http')) {
      return 'https://your-base-url.com/$url'; // عدل هنا بالـ base URL الفعلي
    }

    return url;
  }
}
