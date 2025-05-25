import 'package:dentalog/Features/home/presentation/views/widgets/appointment_view_body.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key, required this.doctorId});
final int doctorId ;
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
      body: AppointmentViewBody(doctorId: doctorId,),
    );
  }
}
