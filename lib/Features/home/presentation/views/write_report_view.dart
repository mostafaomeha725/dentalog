import 'package:dentalog/Features/home/presentation/manager/cubit/rebort_creation_by_doctor_cubit/rebortcreationbydoctor_cubit.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/write_report_view_body.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteReportView extends StatelessWidget {
  const WriteReportView({super.key, required this.id});
final int id ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RebortcreationbydoctorCubit>(
      create: (context) => RebortcreationbydoctorCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(0xff134FA2)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Report",
            style: TextStyles.bold20w500,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: WriteReportViewBody(appointmentId: id,),
      ),
    );
  }
}
