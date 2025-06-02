import 'package:dentalog/Features/home/presentation/manager/cubit/update_ppointment_status_cubit/updateappointmentstatus_cubit.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/utiles/app_images.dart'; // للتعامل مع صورة الأفاتار الافتراضية
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WaitingCard extends StatelessWidget {
  const WaitingCard({
    super.key,
    required this.appointmentId,
    required this.doctorName,
    required this.phoneNumber,
    required this.image,
    required this.dateTime,
    required this.status,
  });

  final int appointmentId;
  final String doctorName;
  final String phoneNumber;
  final String image;
  final DateTime dateTime;
  final String status;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('d MMM').format(dateTime);
    final formattedTime = DateFormat.jm().format(dateTime);

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
              offset: const Offset(0, -3),
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
                  backgroundImage: _getImageProvider(image),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctorName, style: TextStyles.bold16w600),
                    const SizedBox(height: 4),
                    Text(
                      phoneNumber,
                      style: TextStyles.bold14w400Inter.copyWith(color: Colors.grey),
                    ),
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
                    const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xff134FA2)),
                    const SizedBox(width: 4),
                    Text(
                      '$formattedDate, $formattedTime',
                      style: TextStyles.bold12w500inter.copyWith(color: const Color(0xff134FA2)),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.info_outline, size: 16, color: Color(0xff134FA2)),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: TextStyles.bold12w500inter.copyWith(color: const Color(0xff134FA2)),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Confirm Button
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: status == 'waiting'
                    ? () {
                        context.read<UpdateAppointmentStatusCubit>().updateStatus(
                              appointmentId: appointmentId,
                              status: 'completed', // أو حسب المطلوب من الباكند
                            );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                ),
                child: Text(
                  "Confirm",
                  style: TextStyles.bold13w500.copyWith(color: const Color(0xff134FA2)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(String? url) {
    if (url != null && url.trim().isNotEmpty) {
      // معالجة الرابط الخاطئ أو المتكرر
      if (url.contains('optima-software-solutions.com/dentalog/https')) {
        url = url.replaceFirst('http://optima-software-solutions.com/dentalog/', '');
      }
      return NetworkImage(url);
    } else {
      // صورة افتراضية عند غياب الرابط
      return const AssetImage(Assets.assetsProfileAvater);
    }
  }
}
