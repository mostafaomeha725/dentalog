import 'package:dentalog/Features/home/presentation/manager/cubit/update_ppointment_status_cubit/updateappointmentstatus_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:dentalog/core/app_router/app_router.dart';

import 'Appointment_card.dart';

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

    if (result != null &&
        result['selectedDate'] != null &&
        result['selectedTime'] != null) {
      final selectedDate = result['selectedDate'] as DateTime;
      final selectedTime = result['selectedTime'] as String;

      setState(() {
        appointments[index]['appointment_date'] = selectedDate.toIso8601String();
        appointments[index]['appointment_time'] = selectedTime;
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

        final datePart = appointment['appointment_date'];
        final timePart = appointment['appointment_time'];

        final parsedDate = DateTime.parse(datePart);
        final timeParts = timePart.split(':');
        final dateTime = DateTime(
          parsedDate.year,
          parsedDate.month,
          parsedDate.day,
          int.parse(timeParts[0]),
          int.parse(timeParts[1]),
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



class DoctorAppointmentListWaiting extends StatefulWidget {
  final List<dynamic> initialAppointments;

  const DoctorAppointmentListWaiting({super.key, required this.initialAppointments});

  @override
  State<DoctorAppointmentListWaiting> createState() => _DoctorAppointmentListWaitingState();
}

class _DoctorAppointmentListWaitingState extends State<DoctorAppointmentListWaiting> {
  late List<dynamic> appointments;
  int? selectedIndex;

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

    if (result != null &&
        result['selectedDate'] != null &&
        result['selectedTime'] != null) {
      final selectedDate = result['selectedDate'] as DateTime;
      final selectedTime = result['selectedTime'] as String;

      setState(() {
        appointments[index]['appointment_date'] = selectedDate.toIso8601String();
        appointments[index]['appointment_time'] = selectedTime;
        appointments[index]['status'] = 'Rescheduled';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateAppointmentStatusCubit, UpdateAppointmentStatusState>(
      listener: (context, state) {
        if (state is UpdateAppointmentStatusSuccess) {
          if (selectedIndex != null && selectedIndex! < appointments.length) {
            setState(() {
              appointments.removeAt(selectedIndex!);
              selectedIndex = null;
            });
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم تحديث حالة الموعد بنجاح')),
          );
        } else if (state is UpdateAppointmentStatusFailure) {
          selectedIndex = null;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل في تحديث الحالة: ${state.error}')),
          );
        }
      },
      builder: (context, state) {
        if (state is UpdateAppointmentStatusLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            final appointment = appointments[index];

            final datePart = appointment['appointment_date'];
            final timePart = appointment['appointment_time'];

            DateTime? dateTime;
            try {
              final parsedDate = DateTime.parse(datePart);
              final timeParts = timePart.split(':');
              final hours = int.parse(timeParts[0]);
              final minutes = int.parse(timeParts[1]);

              dateTime = DateTime(
                parsedDate.year,
                parsedDate.month,
                parsedDate.day,
                hours,
                minutes,
              );
            } catch (e) {
              return const SizedBox();
            }

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
              isdoctor: true,
              onPressed: () {
                selectedIndex = index;
                final appointmentId = appointment['id'];
                context.read<UpdateAppointmentStatusCubit>().updateStatus(
                  appointmentId: appointmentId,
                  status: 'completed',
                );
              },
              oncanceled: () {
                selectedIndex = index;
                final appointmentId = appointment['id'];
                context.read<UpdateAppointmentStatusCubit>().updateStatus(
                  appointmentId: appointmentId,
                  status: 'canceled',
                );
              },
            );
          },
        );
      },
    );
  }
}
