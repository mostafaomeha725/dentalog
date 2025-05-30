import 'package:dentalog/Features/home/presentation/views/widgets/appointment_view_body.dart';
import 'package:flutter/material.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';

class AppointmentView extends StatelessWidget {
  final int doctorId;

  const AppointmentView({
    super.key,
    required this.doctorId,
   
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff134FA2)),
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
      body: AppointmentViewBody(
        doctorId: doctorId,
      ),
    );
  }
}
