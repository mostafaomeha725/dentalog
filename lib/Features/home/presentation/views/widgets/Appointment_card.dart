import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatelessWidget {
  final int appointmentId;
  final String doctorName;
  final String phoneNumber;
  final String image;
  final DateTime dateTime;
  final String status;
  final bool iscompleted;
  final VoidCallback? onReschedulePressed;
  final bool isdoctor ;
  final void Function()? onPressed ;

  const AppointmentCard({
    super.key,
    required this.appointmentId,
    required this.doctorName,
    required this.phoneNumber,
    required this.image,
    required this.dateTime,
    required this.status,
    this.iscompleted = false,
    this.onReschedulePressed,
    this.isdoctor = false, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMMd().format(dateTime);
    final formattedTime = DateFormat.jm().format(dateTime);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: image.isNotEmpty ? NetworkImage(image) : null,
              child: image.isEmpty ? const Icon(Icons.person, size: 40) : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctorName, style: TextStyles.bold16w600),
                    const SizedBox(height: 6),
                    Text(
                      phoneNumber,
                      style: TextStyles.bold14w400Inter.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 26),
                    Row(
                      children: [
                        const Icon(Icons.calendar_month, size: 16, color: Color(0xff134FA2)),
                        const SizedBox(width: 6),
                        Text(
                          formattedDate,
                          style: TextStyles.bold12w500inter.copyWith(color: const Color(0xff134FA2)),
                        ),
                        SizedBox(width: 12,),
                         Text(
                          formattedTime,
                          style: TextStyles.bold12w500inter.copyWith(color: const Color(0xff134FA2)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                   
                
                isdoctor?   Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor:Colors.blue.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                ),
                child:  Text("Confirm",style: TextStyles.bold13w500.copyWith(color: Color(0xff134FA2)),),
              ),
            ) :Row(
                      children: [
                        const Icon(Icons.info_outline, size: 16, color: Color(0xff134FA2)),
                        const SizedBox(width: 6),
                        Text(
                          status,
                          style: TextStyles.bold12w500inter.copyWith(color: const Color(0xff134FA2)),
                        ),
                      ],
                    ),
                    if (!iscompleted)
                     Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        isdoctor? SizedBox(): TextButton(
                            onPressed: onReschedulePressed,
                            child: Text(
                              "Reschedule",
                              style: TextStyles.bold12w500inter.copyWith(color: const Color(0xff134FA2)),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: Implement cancellation logic
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyles.bold12w500inter.copyWith(color: const Color(0xff134FA2)),
                            ),
                          ),
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
