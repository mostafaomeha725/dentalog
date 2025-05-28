import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WaitingCard extends StatelessWidget {
  const WaitingCard({
    super.key,
    required this.doctorName,
    required this.phoneNumber,
    required this.image,
    required this.dateTime,
    required this.status,
  });

  final String doctorName;
  final String phoneNumber;
  final String image;
  final DateTime dateTime;
  final String status;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('d MMM').format(dateTime);  // 10 Feb
    final formattedTime = DateFormat.jm().format(dateTime);      // 2:00 PM

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Info
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(image),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctorName, style: TextStyles.bold16w600),
                    const SizedBox(height: 4),
                    Text(phoneNumber,
                        style: TextStyles.bold14w400Inter
                            .copyWith(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
      
            // Info row (Date, Time, Status)
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xff134FA2)),
                    const SizedBox(width: 4),
                    Text('$formattedDate, $formattedTime',
                        style: TextStyles.bold12w500inter.copyWith(color: Color(0xff134FA2))),
                  ],
                ),
                SizedBox(height: 6,),
                Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: Color(0xff134FA2)),
                    const SizedBox(width: 4),
                    Text(status,
                        style: TextStyles.bold12w500inter.copyWith(color: Color(0xff134FA2))),
                  ],
                ),
              ],
            ),
      
            const SizedBox(height: 16),
      
            // Confirm Button
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:Colors.blue.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                ),
                child:  Text("Confirm",style: TextStyles.bold13w500.copyWith(color: Color(0xff134FA2)),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
