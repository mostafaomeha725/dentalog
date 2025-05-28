import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'appointment_card.dart';
import 'package:go_router/go_router.dart';
import 'package:dentalog/core/app_router/app_router.dart';

class AppointmentListWaiting extends StatefulWidget {
  final List<dynamic> initialAppointments;

  const AppointmentListWaiting({super.key, required this.initialAppointments});

  @override
  State<AppointmentListWaiting> createState() => _AppointmentListWaitingState();
}

class _AppointmentListWaitingState extends State<AppointmentListWaiting> {
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

      // لو حابب تبعت التحديث لـ API أو Cubit:
      // context.read<RescheduleCubit>().rescheduleAppointment(
      //   appointmentId: appointment['id'],
      //   appointmentDate: DateFormat('yyyy-MM-dd').format(selectedDate),
      //   appointmentTime: formattedTime,
      // );
    }
  }

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
