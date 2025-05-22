import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class PatientDetailesViewBody extends StatelessWidget {
  const PatientDetailesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text("Information", style: TextStyles.bold18w500),
          ),

          const SizedBox(height: 10),

          _buildInfoField("Name", "Ahmed Mohamed"),
          _buildInfoField("Phone", "01022994635"),
          _buildInfoField("Age", "43"),
          _buildInfoField("Gender", "Male"),
          _buildInfoField("City", "Kafkhr El-Shei"),

          const Spacer(),

          // Floating Action Button
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                // Action for sending report
              },
              child: const Icon(Icons.picture_as_pdf, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyles.bold12w400.copyWith(color: Color(0xff134FA2))),
        const SizedBox(height: 4),
        Container(
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
            readOnly: true,
            //  maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  TextStyles.bold16w500.copyWith(color: Color(0xff6D6565)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
