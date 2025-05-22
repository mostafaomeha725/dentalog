import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentViewBody extends StatefulWidget {
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
                    color: Colors.black.withOpacity(0.15), // ظل أكثر وضوحًا
                    blurRadius: 6,
                    spreadRadius: 2, // تمديد الظل قليلاً حول العنصر
                    offset: Offset(0,
                        3), // تحريك الظل للأسفل قليلًا لمحاكاة التأثير الطبيعي
                  ),
                ],
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2025, 12, 31),
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
                      color:
                          isSelected ? Color(0xff134FA2) : Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      time,
                      style: isSelected
                          ? TextStyles.bold13w500.copyWith(color: Colors.white)
                          : TextStyles.bold13w500
                              .copyWith(color: Color(0xff134FA2)),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 60,
            ),
            //  Spacer(),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Color(0xff134FA2),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     padding: EdgeInsets.symmetric(vertical: 16),
            //   ),
            //   onPressed: () {
            //     if (_selectedTime != null) {
            //       // Proceed to the next step
            //       print(
            //           "Appointment booked for $_selectedDate at $_selectedTime");
            //     }
            //     GoRouter.of(context).go(AppRouter.kBookAppointmentView);
            //   },
            //   child: Center(
            //     child: Text(
            //       "Next",
            //       style: TextStyle(fontSize: 16, color: Colors.white),
            //     ),
            //   ),
            // ),
            CustomButtom(
              text: "Next",
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kBookAppointmentView);
              },
              issized: true,
            ),
          ],
        ),
      ),
    );
  }
}
