import 'package:dentalog/Features/home/presentation/manager/cubit/doctor_rating_cubits/doctor_rating_cubit.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/doctor_info_view_body.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorInfoView extends StatelessWidget {
  const DoctorInfoView({super.key, required this.doctor});
  final Map doctor;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorRatingCubit>(
      create: (context) => DoctorRatingCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(0xff134FA2)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Doctor  Details",
            style: TextStyles.bold20w500,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: DoctorInfoViewBody(
          doctor: doctor,
        ),
      ),
    );
  }
}
