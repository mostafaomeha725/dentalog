import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'appointment_card.dart';
import 'package:dentalog/core/app_router/app_router.dart';

class AppointmentListUpcoming extends StatefulWidget {
  final List<dynamic> initialAppointments;

  const AppointmentListUpcoming({super.key, required this.initialAppointments});

  @override
  State<AppointmentListUpcoming> createState() => _AppointmentListUpcomingState();
}

class _AppointmentListUpcomingState extends State<AppointmentListUpcoming> {
  late List<dynamic> appointments;

  @override
  void initState() {
    super.initState();
    appointments = List.from(widget.initialAppointments);
  }

  Future<void> _onReschedulePressed(int index) async {
    final appointment = appointments[index];

    final result = await context.push<Map<String, dynamic>?>(
      AppRouter.krescheduleappointmentView,
      extra: {
        'doctorId': appointment['doctor']['id'],
        'appointmentId': appointment['id'],
        'isFromReschedule': true,
      },
    );

    if (result != null && result['selectedDate'] != null && result['selectedTime'] != null) {
      final selectedDate = result['selectedDate'] as DateTime;
      final formattedTime = result['selectedTime'] as String;

      setState(() {
        appointments[index]['appointment_date'] = selectedDate.toIso8601String();
        appointments[index]['appointment_time'] = formattedTime;
        appointments[index]['status'] = 'Rescheduled';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        final parsedDate = DateTime.parse(appointment['appointment_date']);
        final timeParts = appointment['appointment_time'].split(':');
        final dateTime = DateTime(parsedDate.year, parsedDate.month, parsedDate.day,
            int.parse(timeParts[0]), int.parse(timeParts[1]));

        return AppointmentCard(
          appointmentId: appointment['id'],
          doctorName: appointment['doctor']['user']['name'],
          phoneNumber: appointment['doctor']['phone'],
          image: appointment['doctor']['user']['image'] ?? "",
          dateTime: dateTime,
          status: appointment['status'],
          iscompleted: appointment['status'].toLowerCase() == 'completed',
          onReschedulePressed: () => _onReschedulePressed(index),
        );
      },
    );
  }
}
