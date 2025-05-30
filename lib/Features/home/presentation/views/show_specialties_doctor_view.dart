import 'package:dentalog/Features/home/presentation/views/widgets/Doctor_view_body.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/doctor_home_view_body.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/show_specialties_doctor_view_body.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ShowSpecialtiesDoctorView extends StatelessWidget {
  const ShowSpecialtiesDoctorView({super.key, required this.id, required this.name, });
  final int id ;
  final String name ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff134FA2)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          name,
          style: TextStyles.bold20w500,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ShowSpecialtiesDoctorViewBody(id:id,name: name,istrue: true,),
      ),
    );
  }
}