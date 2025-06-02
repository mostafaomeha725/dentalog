import 'package:dentalog/Features/home/presentation/manager/cubit/reschedule_cubit/reschedule_cubit.dart';
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
  int? selectedIndex;
  String? pendingStatus;

  @override
  void initState() {
    super.initState();
    appointments = List.from(widget.initialAppointments);
  }

  Future<void> _onReschedulePressed(int index) async {
    final appointment = appointments[index];

    final doctorIdRaw = appointment['doctor']?['id'];
    final appointmentIdRaw = appointment['id'];

    final int? doctorId = doctorIdRaw is int ? doctorIdRaw : int.tryParse(doctorIdRaw.toString());
    final int? appointmentId = appointmentIdRaw is int ? appointmentIdRaw : int.tryParse(appointmentIdRaw.toString());

    if (doctorId == null || appointmentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('"Invalid appointment or doctor ID"')),
      );
      return;
    }

    final result = await context.push<Map<String, dynamic>?>( 
      AppRouter.krescheduleappointmentView,
      extra: {
        'doctorId': doctorId,
        'appointmentId': appointmentId,
        'isFromReschedule': true,
      },
    );

    if (result != null &&
        result['selectedDate'] != null &&
        result['selectedTime'] != null) {
      final selectedDate = result['selectedDate'] as DateTime;
      final selectedTime = result['selectedTime'] as String;

      context.read<RescheduleCubit>().rescheduleAppointment(
            appointmentId: appointmentId,
            appointmentDate: selectedDate.toIso8601String(),
            appointmentTime: selectedTime,
          );

      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateAppointmentStatusCubit, UpdateAppointmentStatusState>(
          listener: (context, state) {
            if (state is UpdateAppointmentStatusSuccess) {
              if (selectedIndex != null && selectedIndex! < appointments.length) {
                setState(() {
                  appointments.removeAt(selectedIndex!);
                  selectedIndex = null;
                  pendingStatus = null;
                });
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Appointment status updated successfully')),
              );
            } else if (state is UpdateAppointmentStatusFailure) {
              selectedIndex = null;
              pendingStatus = null;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to update status: ${state.error}')),
              );
            }
          },
        ),
        BlocListener<RescheduleCubit, RescheduleState>(
          listener: (context, state) {
            if (state is RescheduleSuccess) {
              if (selectedIndex != null && selectedIndex! < appointments.length) {
                setState(() {
                  appointments[selectedIndex!]['appointment_date'] = state.response['appointment_date'];
                  appointments[selectedIndex!]['appointment_time'] = state.response['appointment_time'];
                  appointments[selectedIndex!]['status'] = 'Rescheduled';
                  selectedIndex = null;
                });
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('The appointment has been successfully rescheduled.')),
              );
            } else if (state is RescheduleFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to reschedule appointment: ${state.error}')),
              );
            }
          },
        ),
      ],
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];

          final datePart = appointment['appointment_date'];
          final timePart = appointment['appointment_time'];

          DateTime? dateTime;

          try {
            if (datePart is! String || timePart is! String) throw Exception("Invalid date/time format");

            final parsedDate = DateTime.parse(datePart);
            final timeParts = timePart.split(':');

            if (timeParts.length < 2) throw Exception("Invalid time format");

            final hours = int.tryParse(timeParts[0]) ?? 0;
            final minutes = int.tryParse(timeParts[1]) ?? 0;

            dateTime = DateTime(parsedDate.year, parsedDate.month, parsedDate.day, hours, minutes);
          } catch (e) {
            debugPrint("Error parsing date/time: $e");
            return const SizedBox();
          }

          final doctor = appointment['doctor'];
          final doctorUser = doctor?['user'];
          final name = doctorUser?['name'] ?? 'Unknown';
          final phone = doctor?['phone'] ?? 'N/A';
          final image = doctorUser?['image'] ?? '';

          final appointmentId = appointment['id'] is int
              ? appointment['id']
              : int.tryParse(appointment['id'].toString());

          return AppointmentCard(
            appointmentId: appointmentId,
            doctorName: name,
            phoneNumber: phone,
            image: image,
            dateTime: dateTime,
            status: appointment['status'],
            iscompleted: appointment['status'].toString().toLowerCase() == 'completed',
            onReschedulePressed: () => _onReschedulePressed(index),
            isdoctor: false,
            oncanceled: () {
              selectedIndex = index;
              pendingStatus = 'canceled';
              context.read<UpdateAppointmentStatusCubit>().updateStatus(
                    appointmentId: appointmentId,
                    status: 'canceled',
                  );
            },
            onPressed: () {
              selectedIndex = index;
              pendingStatus = 'waiting';
              context.read<UpdateAppointmentStatusCubit>().updateStatus(
                    appointmentId: appointmentId,
                    status: 'waiting',
                  );
            },
          );
        },
      ),
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
            const SnackBar(content: Text('Appointment status updated successfully')),
          );
        } else if (state is UpdateAppointmentStatusFailure) {
          selectedIndex = null;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update status: ${state.error}')),
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
