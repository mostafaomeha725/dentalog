import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class WriteReportViewBody extends StatelessWidget {
  const WriteReportViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.all(16),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Diagnosis"),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "The diagnostic results indicate that the patient has pneumonia, which is possible that the patient is infected with the Covid-19 virus, so the patient must do a Covid-19 swab.",
                  style:
                      TextStyles.bold12w400.copyWith(color: Color(0xff6D6565)),
                ),
              ),
              const SizedBox(height: 16),
              _buildSectionTitle("Advices"),
              SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Complete rest throughout the day and do not do any effort until you recover.\n"
                  "Drink plenty of fluids to help thin the mucus.\n"
                  "Quit smoking and avoid passive smoking.\n"
                  "Lie down with your head and back elevated to help you breathe better.",
                  style:
                      TextStyles.bold12w400.copyWith(color: Color(0xff6D6565)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: TextStyles.bold16w500);
  }
}
