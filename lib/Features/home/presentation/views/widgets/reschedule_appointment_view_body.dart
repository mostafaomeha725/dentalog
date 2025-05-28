import 'package:dentalog/core/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';

class RescheduleAppointmentViewBody extends StatefulWidget {
  final int doctorId;
  final int appointmentId;
  final bool isFromReschedule;

  const RescheduleAppointmentViewBody({
    super.key,
    required this.doctorId,
    required this.appointmentId,
    required this.isFromReschedule,
  });

  @override
  _RescheduleAppointmentViewBodyState createState() =>
      _RescheduleAppointmentViewBodyState();
}

class _RescheduleAppointmentViewBodyState
    extends State<RescheduleAppointmentViewBody> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;

  final List<String> timeSlots = [
    "8:00 AM", "9:00 AM", "10:00 AM", "12:00 PM",
    "2:00 PM", "4:00 PM", "6:00 PM", "8:00 PM"
  ];

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
                  });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: const BoxDecoration(
                    color: Color(0xff134FA2),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Color(0xff134FA2),
                    shape: BoxShape.circle,
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
            Wrap(
              spacing: 8,
              runSpacing: 12,
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
                      style: TextStyles.bold13w500.copyWith(
                        color: isSelected ? Colors.white : const Color(0xff134FA2),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 60),
            CustomButtom(
              text: "Next",
              onPressed: () {
                if (_selectedTime != null) {
                  final formattedTime = _formatTime(_selectedTime!);
                  context.pop({
                    'selectedDate': _selectedDate,
                    'selectedTime': formattedTime,
                  });
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
    final int minute = int.parse(parts[1]);
    final String period = parts[2];

    if (period == "PM" && hour != 12) hour += 12;
    if (period == "AM" && hour == 12) hour = 0;

    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = minute.toString().padLeft(2, '0');

    return '$hourStr:$minuteStr:00';
  }
}
