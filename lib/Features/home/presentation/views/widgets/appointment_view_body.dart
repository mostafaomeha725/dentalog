import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // <-- تأكد من إضافة هذه المكتبة

class AppointmentViewBody extends StatefulWidget {
  const AppointmentViewBody({super.key, required this.doctorId});
final int doctorId ;
  @override
  _AppointmentViewBodyState createState() => _AppointmentViewBodyState();
}

class _AppointmentViewBodyState extends State<AppointmentViewBody> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;

  List<String> timeSlots = [
    "8:00 AM",
    "9:00 AM",
    "10:00 AM",
    "12:00 AM",
    "2:00 PM",
    "4:00 PM",
    "6:00 PM",
    "8:00 PM"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text(
              "Select Date",
              style: TextStyles.bold16w500,
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 6,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TableCalendar(
                firstDay: DateTime.now(),
              lastDay: DateTime.now().add(Duration(days: 365)),

                focusedDay: _selectedDate,
                selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Color(0xff134FA2),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Color(0xff134FA2),
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Select Time",
              style: TextStyles.bold16w500,
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 3,
              runSpacing: 10,
              children: timeSlots.map((time) {
                bool isSelected = _selectedTime == time;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTime = time;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xff134FA2) : Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      time,
                      style: isSelected
                          ? TextStyles.bold13w500.copyWith(color: Colors.white)
                          : TextStyles.bold13w500.copyWith(color: Color(0xff134FA2)),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 60),
            CustomButtom(
              text: "Next",
             onPressed: () {
  if (_selectedTime != null) {
    // ✅ صيغة الوقت 24 ساعة
    String formattedTime = _formatTime(_selectedTime!);

    GoRouter.of(context).push(
      AppRouter.kBookAppointmentView,
      extra: {
        'selectedDate': _selectedDate, // ⬅️ DateTime مباشرة
        'selectedTime': formattedTime,
        'DoctorId':widget.doctorId // ⬅️ String
      },
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please select a time.")),
    );
  }
},

              issized: true,
            )
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
