import 'package:dentalog/Features/home/presentation/views/widgets/Custom_list_title.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/waiting_list_view_body.dart';
import 'package:flutter/material.dart';

class DoctorHomeViewBody extends StatelessWidget {
  const DoctorHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CustomListTitle(),
            ),
            const SizedBox(height: 16),
            const Expanded(
              child: WaitingListViewBody(isuser: false,),
            ),
          ],
        ),
      ),
    );
  }
}
