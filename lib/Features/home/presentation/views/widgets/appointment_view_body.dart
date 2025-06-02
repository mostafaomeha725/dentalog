import 'package:dentalog/Features/home/presentation/manager/cubit/Doctor_Schedules_cubit/doctor_schedules_cubit.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentViewBody extends StatefulWidget {
  final int doctorId;

  const AppointmentViewBody({
    Key? key,
    required this.doctorId,
  }) : super(key: key);

  @override
  _AppointmentViewBodyState createState() => _AppointmentViewBodyState();
}

class _AppointmentViewBodyState extends State<AppointmentViewBody> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    context.read<DoctorSchedulesCubit>().fetchDoctorSchedules(widget.doctorId);
  }

  List<String> _buildAvailableSlots(BuildContext context, DoctorSchedule schedule) {
    final startParts = schedule.startTime.split(':').map(int.parse).toList();
    final endParts = schedule.endTime.split(':').map(int.parse).toList();

    final start = TimeOfDay(hour: startParts[0], minute: startParts[1]);
    final end = TimeOfDay(hour: endParts[0], minute: endParts[1]);

    List<String> slots = [];
    TimeOfDay current = start;

    while (current.hour < end.hour || (current.hour == end.hour && current.minute < end.minute)) {
      final formattedTime = current.format(context);
      slots.add(formattedTime);

      // Increment by 1 hour
      current = TimeOfDay(hour: current.hour + 1, minute: current.minute);
    }

    return slots;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text("Select Date", style: TextStyles.bold16w500),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 6,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                focusedDay: _selectedDate,
                selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                    _selectedTime = null; // إعادة التهيئة عند تغيير التاريخ
                  });
                },
                 calendarStyle: CalendarStyle(
  todayDecoration: BoxDecoration(
    color: isSameDay(_selectedDate, DateTime.now())
        ? const Color(0xff134FA2)
        : Colors.transparent,
    shape: BoxShape.circle,
  ),
  selectedDecoration: const BoxDecoration(
    color: Color(0xff134FA2),
    shape: BoxShape.circle,
  ),
  selectedTextStyle: const TextStyle(
    color: Colors.white, // لون اليوم المختار
    fontWeight: FontWeight.bold,
  ),
  todayTextStyle: const TextStyle(
    color: Colors.black, // لون اليوم الحالي
    fontWeight: FontWeight.bold,
  ),
),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Select Time", style: TextStyles.bold16w500),
            const SizedBox(height: 16),
            BlocBuilder<DoctorSchedulesCubit, DoctorSchedulesState>(
              builder: (context, state) {
                if (state is DoctorSchedulesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DoctorSchedulesSuccess) {
                  final weekday = _selectedDate.weekday;
                  final schedules = state.schedulesData
                      .map((e) => DoctorSchedule.fromJson(e))
                      .where((s) => s.dayOfWeek == weekday)
                      .toList();

                  if (schedules.isEmpty) {
                    return const Text("No available times for this day.");
                  }

                  final timeSlots = _buildAvailableSlots(context, schedules.first);

                  return Wrap(
                    spacing: 3,
                    runSpacing: 10,
                    children: timeSlots.map((time) {
                      final isSelected = _selectedTime == time;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTime = time;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xff134FA2) : Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            time,
                            style: isSelected
                                ? TextStyles.bold13w500.copyWith(color: Colors.white)
                                : TextStyles.bold13w500.copyWith(color: const Color(0xff134FA2)),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else if (state is DoctorSchedulesFailure) {
                  return Text(state.errorMessage, style: const TextStyle(color: Colors.red));
                } else {
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(height: 60),
            CustomButtom(
              text: "Next",
              onPressed: () {
                if (_selectedTime != null) {
                  final formattedTime = _formatTime(_selectedTime!);
                  GoRouter.of(context).push(
                    AppRouter.kBookAppointmentView,
                    extra: {
                      'selectedDate': _selectedDate,
                      'selectedTime': formattedTime,
                      'DoctorId': widget.doctorId,
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a time.")),
                  );
                }
              },
              issized: true,
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String time12h) {
    final parts = time12h.split(RegExp(r'[: ]'));
    int hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    final period = parts[2];

    if (period == "PM" && hour != 12) hour += 12;
    if (period == "AM" && hour == 12) hour = 0;

    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');

    return '$hourStr:$minuteStr:00';
  }
}


class DoctorSchedule {
  final int id;
  final int doctorId;
  final int dayOfWeek;
  final String startTime;
  final String endTime;

  DoctorSchedule({
    required this.id,
    required this.doctorId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  factory DoctorSchedule.fromJson(Map<String, dynamic> json) {
    return DoctorSchedule(
      id: int.parse(json['id'].toString()),
      doctorId: int.parse(json['doctor_id'].toString()),
      dayOfWeek: int.parse(json['day_of_week'].toString()),
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}
