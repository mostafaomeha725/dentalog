import 'package:dentalog/Features/home/presentation/manager/cubit/reschedule_cubit/reschedule_cubit.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/show_Appointments_cubit/show_appointments_cubit.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/Appointment_list_upcoming.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/appointment_list_completed.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/appointment_list_waiting.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    context.read<ShowAppointmentsCubit>().fetchAppointments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RescheduleCubit>(
        create: (context) => RescheduleCubit(),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: const Color(0xff134FA2),
                labelStyle: TextStyles.bold13w400,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                tabs: const [
                  Tab(text: "Upcoming"),
                  Tab(text: "Waiting"),
                  Tab(text: "Completed"),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<ShowAppointmentsCubit, ShowAppointmentsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is ShowAppointmentsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ShowAppointmentsFailure) {
                    return Center(child: Text(state.errorMessage));
                  } else if (state is ShowAppointmentsSuccess) {
                    final appointments = state.appointmentsData;
      
                    // Debug: طباعة أنواع الحالات
                    for (var a in appointments) {
                      debugPrint("Status: ${a['status']}");
                    }
      
                    final upcoming = appointments
                        .where((a) =>
                            a['status'].toString().toLowerCase() == 'upcoming')
                        .toList();
                    final waiting = appointments
                        .where((a) =>
                            a['status'].toString().toLowerCase() == 'waiting')
                        .toList();
                    final completed = appointments
                        .where((a) =>
                            a['status'].toString().toLowerCase() == 'completed')
                        .toList();
      
                    return TabBarView(
                      controller: _tabController,
                      children: [
                       AppointmentListUpcoming(initialAppointments: upcoming),
                        AppointmentListWaiting(initialAppointments: waiting),
                        AppointmentListCompleted(appointments: completed),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
