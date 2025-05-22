import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';

class BookAppointmentViewBody extends StatefulWidget {
  const BookAppointmentViewBody({super.key});

  @override
  State<BookAppointmentViewBody> createState() =>
      _BookAppointmentViewBodyState();
}

class _BookAppointmentViewBodyState extends State<BookAppointmentViewBody> {
  String? _selectedGender;

  final List<String> _genders = ["Male", "Female"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set Information",
              style: TextStyles.bold16w500,
            ),
            SizedBox(height: 10),
            buildTextField("Name"),
            buildTextField("Phone"),
            buildTextField("Age"),
            buildDropdownField(),
            buildTextField("Address"),
            buildTextField("Describe Your Problem (Optional)"),
            //  Spacer(),
            SizedBox(height: 120),
            CustomButtom(
              text: "Confirm",
              onPressed: () {
                //    GoRouter.of(context).push(AppRouter.kHomeView);
              },
              issized: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hint, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15), // ظل أكثر وضوحًا
              blurRadius: 6,
              spreadRadius: 2, // تمديد الظل قليلاً حول العنصر
              offset: Offset(
                  0, 3), // تحريك الظل للأسفل قليلًا لمحاكاة التأثير الطبيعي
            ),
          ],
        ),
        child: TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyles.bold16w500.copyWith(color: Color(0xff6D6565)),
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15), // More visible shadow
              blurRadius: 6, // Softens the shadow
              spreadRadius: 2, // Expands the shadow
              offset: Offset(0, 3), // Moves the shadow slightly downward
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            value: _selectedGender,
            isDense: true, // ✅ تصغير الحجم
            icon: Transform.rotate(
              angle:
                  270 * (3.141592653589793 / 180), // تحويل 90 درجة إلى راديان
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff134FA2),
              ),
            ), // ✅ تغيير شكل الأيقونة
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none, // Removes default border
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                  vertical: 8, horizontal: 12), // ✅ تصغير الحشو
            ),
            hint: Text("Gender"),
            items: _genders.map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Row(
                  children: [
                    // Icon(Icons.person,
                    //     color: Colors.blue), // ✅ إضافة أيقونة بجانب النص
                    // SizedBox(width: 8),
                    Text(gender),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedGender = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
