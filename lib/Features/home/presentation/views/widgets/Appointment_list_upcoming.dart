import 'package:dentalog/Features/home/presentation/views/widgets/Appointment_card.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:flutter/material.dart';

class AppointmentListUpcoming extends StatelessWidget {
  const AppointmentListUpcoming({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      children: [
        AppointmentCard(
          doctorName: "Dr. Mohamed Ahmed",
          phoneNumber: "01094059584",
          image: Assets.assetsDrKareem,
          dateTime: "10 Feb, 2:00 PM",
          status: "Confirmed",
        ),
      ],
    );
  }
}
