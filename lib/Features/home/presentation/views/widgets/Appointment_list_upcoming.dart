import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import 'appointment_card.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/appointment_view_body.dart';
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
        'isFromUpdate': true,
      },
    );

    if (result != null &&
        result['selectedDate'] != null &&
        result['selectedTime'] != null) {
      final selectedDate = result['selectedDate'] as DateTime;
      final selectedTime = result['selectedTime'] as String;

      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      final formattedTime = selectedTime;

      setState(() {
        appointments[index]['appointment_date'] = selectedDate.toIso8601String();
        appointments[index]['appointment_time'] = formattedTime;
        appointments[index]['status'] = 'Rescheduled';
      });

      // يمكنك هنا إرسال البيانات للمخدم (backend) عبر Cubit أو Bloc
      // context.read<RescheduleCubit>().rescheduleAppointment(
      //   appointmentId: appointment['id'],
      //   appointmentDate: formattedDate,
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




class DoctorAppointmentListUpcoming extends StatefulWidget {
  final List<dynamic> initialAppointments;

  const DoctorAppointmentListUpcoming({super.key, required this.initialAppointments});

  @override
  State<DoctorAppointmentListUpcoming> createState() => _DoctorAppointmentListUpcomingState();
}

class _DoctorAppointmentListUpcomingState extends State<DoctorAppointmentListUpcoming> {
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
        'isFromUpdate': true,
      },
    );

    if (result != null &&
        result['selectedDate'] != null &&
        result['selectedTime'] != null) {
      final selectedDate = result['selectedDate'] as DateTime;
      final selectedTime = result['selectedTime'] as String;

      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      final formattedTime = selectedTime;

      setState(() {
        appointments[index]['appointment_date'] = selectedDate.toIso8601String();
        appointments[index]['appointment_time'] = formattedTime;
        appointments[index]['status'] = 'Rescheduled';
      });

      // يمكنك استخدام Cubit أو Bloc هنا لإرسال التعديل للسيرفر
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

        final user = appointment['user'];
        final name = user?['name'] ?? 'Unknown';
        final phone = user?['phone'] ?? 'N/A';
        final image = user?['image'] ?? '';

        return AppointmentCard(
          appointmentId: appointment['id'],
          doctorName: name,
          phoneNumber: phone,
          image: image,
          dateTime: dateTime,
          status: appointment['status'],
          iscompleted: appointment['status'].toLowerCase() == 'completed',
          onReschedulePressed: () => _onReschedulePressed(index),
        );
      },
    );
  }
}
