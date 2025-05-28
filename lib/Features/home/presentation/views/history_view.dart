import 'package:dentalog/Features/home/presentation/manager/cubit/show_history_cubit/showhistory_cubit.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/History_view_body.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShowhistoryCubit>(
      create: (context) => ShowhistoryCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(0xff134FA2)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "History",
            style: TextStyles.bold20w500,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: HistoryViewBody(),
      ),
    );
  }
}
