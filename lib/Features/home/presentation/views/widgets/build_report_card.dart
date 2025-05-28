import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BuildReportCard extends StatelessWidget {
  const BuildReportCard(
      {super.key,
      required this.doctor,
      required this.title,
      required this.time,
      required this.image,
      this.isNew = false, required this.id});
  final String doctor;
  final String title;
  final String time;
  final String image;
  final bool isNew;
  final int id ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        GoRouter.of(context).push(AppRouter.kReportView,extra: id);
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
                    child: CircleAvatar(
                        radius: 30, backgroundImage: AssetImage(image)),
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
                        SizedBox(height: 6),
                        Text(
                          "Report from $doctor",
                          style: TextStyles.bold12w400
                              .copyWith(color: Color(0xff134FA2)),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          time,
                          style: TextStyles.bold14w400
                              .copyWith(color: Color(0xff6D6565)),
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
}
