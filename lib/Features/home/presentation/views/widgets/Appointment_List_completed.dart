import 'package:flutter/material.dart';
import 'appointment_card.dart';

class AppointmentListCompleted extends StatelessWidget {
  final List<dynamic> appointments;

  const AppointmentListCompleted({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];

        final datePart = appointment['appointment_date']; // e.g. "2025-05-27T00:00:00.000000Z"
        final timePart = appointment['appointment_time']; // e.g. "14:00"

        final parsedDate = DateTime.parse(datePart);
        final timeParts = timePart.split(':');
        final hours = int.parse(timeParts[0]);
        final minutes = int.parse(timeParts[1]);

        final dateTime = DateTime(
          parsedDate.year,
          parsedDate.month,
          parsedDate.day,
          hours,
          minutes,
        );

        return AppointmentCard(
          doctorName: appointment['doctor']['user']['name'],
          phoneNumber: appointment['doctor']['phone'],
          image: appointment['doctor']['user']['image']??"",
          dateTime: dateTime,
          status: appointment['status'],
          iscompleted: true, appointmentId: appointment['id'],
        );
      },
    );
  }
}
