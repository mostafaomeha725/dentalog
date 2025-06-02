import 'package:dentalog/Features/home/presentation/manager/cubit/show_report_cubit/showreport_cubit.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/report_view_body.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key, required this.id});
final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShowreportCubit>(
      create: (context) => ShowreportCubit()..fetchReportById(id),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(0xff134FA2)),
            onPressed: () => GoRouter.of(context).pop(),
          ),
          title: Text(
            "Reports",
            style: TextStyles.bold20w500,
          ),
          backgroundColor: Colors.white.withOpacity(0.2),
          elevation: 0,
          centerTitle: true,
        ),
        body: ReportViewBody(),
      ),
    );
  }
}
