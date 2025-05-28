import 'package:flutter/material.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/reschedule_appointment_view_body.dart';

class RescheduleAppoinmentView extends StatelessWidget {
  final int doctorId;
  final int appointmentId;
  final bool isFromReschedule;

  const RescheduleAppoinmentView({
    super.key,
    required this.doctorId,
    required this.appointmentId,
    required this.isFromReschedule,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff134FA2)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Book an Appointment",
          style: TextStyles.bold20w500,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: RescheduleAppointmentViewBody(
        doctorId: doctorId,
        appointmentId: appointmentId,
        isFromReschedule: isFromReschedule,
      ),
    );
  }
}
