import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BuildReportCard extends StatelessWidget {
  const BuildReportCard({
    super.key,
    required this.doctor,
    required this.title,
    required this.time,
    required this.image,
    this.isNew = false,
    required this.id,
  });

  final String doctor;
  final String title;
  final String time;
  final String image;
  final bool isNew;
  final int id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kReportView, extra: id);
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: isNew ? 4 : 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipOval(
                      child: Image(
                        image: _getImageProvider(image),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            Assets.assetsProfileAvater,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyles.bold16w500,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Report from $doctor",
                          style: TextStyles.bold12w400.copyWith(color: const Color(0xff134FA2)),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          time,
                          style: TextStyles.bold14w400.copyWith(color: const Color(0xff6D6565)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔧 Helper function to handle image links safely
  ImageProvider _getImageProvider(String? url) {
    const String baseUrl = 'http://optima-software-solutions.com/dentalog/';

    if (url == null || url.trim().isEmpty) {
      return const AssetImage(Assets.assetsProfileAvater);
    }

    // إزالة التكرار لو الرابط فيه تكرار في الدومين
    if (url.contains('optima-software-solutions.com/dentalog/https')) {
      url = url.replaceFirst('http://optima-software-solutions.com/dentalog/', '');
    }

    // لو الرابط مش بيبدأ بـ http, افترض إنه نسبي
    if (!url.startsWith('http')) {
      url = '$baseUrl$url';
    }

    return NetworkImage(url);
  }
}
