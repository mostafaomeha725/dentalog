import 'package:dentalog/core/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

        final datePart = appointment['appointment_date'];
        final timePart = appointment['appointment_time'];

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

        final doctor = appointment['doctor'];
        final doctorUser = doctor != null ? doctor['user'] : null;
        final user = appointment['user'];

        final name = doctorUser?['name'] ?? user?['name'] ?? 'Unknown';
        final phone = doctor?['phone'] ?? user?['phone'] ?? 'N/A';
        final image = doctorUser?['image'] ?? user?['image'] ?? '';

        return AppointmentCard(
          appointmentId: appointment['id'],
          doctorName: name,
          phoneNumber: phone,
          image: image,
          dateTime: dateTime,
          status: appointment['status'],
          iscompleted: true,
        );
      },
    );
  }
}




class DoctorAppointmentListCompleted extends StatelessWidget {
  final List<dynamic> appointments;

  const DoctorAppointmentListCompleted({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];

        final datePart = appointment['appointment_date'];
        final timePart = appointment['appointment_time'];

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

        final user = appointment['user'];

        final name = user?['name'] ?? 'Unknown';
        final phone = user?['phone'] ?? 'N/A';
        final image = user?['image'] ?? '';

        return GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.kWriteReportView,extra: appointment['id']);
          },
          child: AppointmentCard(
            appointmentId: appointment['id'],
            doctorName: name,
            phoneNumber: phone,
            image: image,
            dateTime: dateTime,
            status: appointment['status'],
            iscompleted: true,
            
          ),
        );
      },
    );
  }
}
