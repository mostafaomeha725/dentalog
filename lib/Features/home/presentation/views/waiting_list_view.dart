import 'package:dentalog/Features/home/presentation/views/widgets/waiting_list_view_body.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class WaitingListView extends StatelessWidget {
  const WaitingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff134FA2)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Waiting List",
          style: TextStyles.bold20w500,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: WaitingListViewBody(),
    );
  }
}