import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.doctorName,
    required this.phoneNumber,
    required this.image,
    required this.dateTime,
    required this.status,
    this.iscompleted = false,
  });
  final String doctorName;
  final String phoneNumber;
  final String image;
  final String dateTime;
  final String status;
  final bool iscompleted;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(image),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctorName, style: TextStyles.bold16w600),
                    SizedBox(height: 6),
                    Text(phoneNumber,
                        style: TextStyles.bold14w400Inter
                            .copyWith(color: Colors.grey)),
                    const SizedBox(height: 26),
                    Row(
                      children: [
                        const Icon(Icons.calendar_month,
                            size: 16, color: Color(0xff134FA2)),
                        const SizedBox(width: 6),
                        Text(dateTime,
                            style: TextStyles.bold12w500inter
                                .copyWith(color: Color(0xff134FA2))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 16, color: Color(0xff134FA2)),
                        const SizedBox(width: 6),
                        Text(status,
                            style: TextStyles.bold12w500inter
                                .copyWith(color: Color(0xff134FA2))),
                      ],
                    ),
                    const SizedBox(height: 6),
                    iscompleted
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Text("Reschedule",
                                      style: TextStyles.bold12w500inter
                                          .copyWith(color: Color(0xff134FA2)))),
                              TextButton(
                                  onPressed: () {},
                                  child: Text("Cancel",
                                      style: TextStyles.bold12w500inter
                                          .copyWith(color: Color(0xff134FA2)))),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
