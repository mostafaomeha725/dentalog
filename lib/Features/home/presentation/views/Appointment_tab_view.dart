import 'package:dentalog/Features/home/presentation/views/widgets/Appointment_List_completed.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/Appointment_list_upcoming.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/Appointment_list_waiting.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppointmentTabView extends StatefulWidget {
  const AppointmentTabView({super.key});

  @override
  State<AppointmentTabView> createState() => _AppointmentTabViewState();
}

class _AppointmentTabViewState extends State<AppointmentTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController
        .dispose(); // إيقاف الـ TabController عند تدمير الواجهة لتجنب تسريبات الذاكرة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TabBar داخل body
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: Color(0xff134FA2),
            labelStyle: TextStyles.bold13w400,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: const [
              Tab(
                text: "Upcoming",
              ),
              Tab(text: "Waiting"),
              Tab(text: "Completed"),
            ],
          ),
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              AppointmentListUpcoming(),
              AppointmentListWaiting(),
              AppointmentListCompleted(),
            ],
          ),
        ),
      ],
    );
  }
}
