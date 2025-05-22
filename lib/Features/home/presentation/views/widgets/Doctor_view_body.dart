import 'package:dentalog/Features/home/presentation/views/widgets/Doctor_card.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/list_doctor_card.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class DoctorViewBody extends StatefulWidget {
  const DoctorViewBody({super.key});

  @override
  State<DoctorViewBody> createState() => _DoctorViewBodyState();
}

class _DoctorViewBodyState extends State<DoctorViewBody> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text("Departments", style: TextStyles.bold18w500),
          SizedBox(height: 32),
          Container(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ListDoctorCard.categories.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: 70,
                    height: 80,
                    margin: EdgeInsets.only(right: 16),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xff134FA2) : Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: ListDoctorCard.categories[index]["icon"] == null
                          ? Text(ListDoctorCard.categories[index]["label"],
                              style: TextStyles.bold18w600
                                  .copyWith(color: Colors.white))
                          : Image.asset(
                              ListDoctorCard.categories[index]["icon"],
                              width: 30,
                              height: 30,
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 30),
          Text("All Doctors",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: ListDoctorCard.doctors.length,
              itemBuilder: (context, index) {
                return DoctorCard(doctor: ListDoctorCard.doctors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
