import 'package:dentalog/Features/home/presentation/views/Appointment_tab_view.dart';
import 'package:dentalog/Features/home/presentation/views/doctor_home_view.dart';
import 'package:dentalog/Features/home/presentation/views/profile_view.dart';
import 'package:dentalog/Features/home/presentation/views/waiting_list_view.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/home_view_body.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    WaitingListView(),
    AppointmentTabView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff9f9f9),
      appBar: AppBar(
        backgroundColor: Color(0xfff9f9f9),
        elevation: 0,
        centerTitle: true,
        // leading: (_selectedIndex == 3 || _selectedIndex == 2)
        //     ? IconButton(
        //         icon:
        //             const Icon(Icons.arrow_back_ios, color: Color(0xff134FA2)),
        //         onPressed: () => Navigator.pop(context),
        //       )
        //     : null,
        title: Text(
            _selectedIndex == 0
                ? "Home"
                : _selectedIndex == 1
                    ? "Appointments"
                    : "Account",
            style: TextStyles.bold20w600),
        actions: [
          if (_selectedIndex == 0) // ✅ إظهار الإشعارات فقط في صفحة "Home"
            IconButton(
              icon:
                  Icon(Icons.notifications, size: 24, color: Colors.grey[700]),
              onPressed: () {},
            ),
        ],
      ),

      // ✅ هنا يتم عرض الصفحة المناسبة بناءً على _selectedIndex
      body: _pages[_selectedIndex],

      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(45),
            bottomRight: Radius.circular(45),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined,
                      color: _selectedIndex == 0
                          ? Color(0xff134FA2)
                          : Colors.grey),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  
                  icon: Icon(Icons.calendar_today,
                      color: _selectedIndex == 1
                          ? Color(0xff134FA2)
                          : Colors.grey),
                  label: "Appointments",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined,
                      color: _selectedIndex == 2
                          ? Color(0xff134FA2)
                          : Colors.grey),
                  label: "Profile",
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Color(0xff134FA2),
              selectedLabelStyle:
                  TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              unselectedItemColor: Colors.grey,
              onTap: _onItemTapped,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}
