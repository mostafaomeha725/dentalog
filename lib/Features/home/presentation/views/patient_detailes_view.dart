import 'package:dentalog/Features/home/presentation/views/widgets/patient_detailes_view_body.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class PatientDetailesView extends StatelessWidget {
  const PatientDetailesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(0xff134FA2)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Reports",
            style: TextStyles.bold20w500,
          ),
          backgroundColor: Colors.white.withOpacity(0.2),
          elevation: 0,
          centerTitle: true,
        ),
        body: PatientDetailesViewBody());
  }
}
