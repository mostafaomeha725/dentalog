import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReportViewBody extends StatelessWidget {
  const ReportViewBody({super.key});

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
              _buildPatientInfoCard(),
              const SizedBox(height: 16),
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
              const SizedBox(height: 26),
              _buildSectionTitle("Medicines"),
              const SizedBox(height: 12),
              _buildMedicineCard("Azithromycin", "once every 12 hours"),
              _buildMedicineCard("Clarithromycin", "Once after lunch"),
              _buildMedicineCard(
                  "Doxycycline", "Once after breakfast and once after dinner"),
              const SizedBox(height: 16),
              _buildDoctorInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientInfoCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.blue), // تحديد لون الحواف
      ),
      elevation: 4,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Patient Name:",
                      style: TextStyles.bold12w500,
                    ),
                    Text(
                      "Age:",
                      style: TextStyles.bold12w500,
                    ),
                    Text(
                      "Gender",
                      style: TextStyles.bold12w500,
                    ),
                    Text(
                      "Report Date:",
                      style: TextStyles.bold12w500,
                    ),
                  ],
                ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ahmed Ali",
                        style: TextStyles.bold12w500
                            .copyWith(color: Color(0xff6D6565))),
                    Text("23",
                        style: TextStyles.bold12w500
                            .copyWith(color: Color(0xff6D6565))),
                    Text("male",
                        style: TextStyles.bold12w500
                            .copyWith(color: Color(0xff6D6565))),
                    Text("17-05-2024    20:18",
                        style: TextStyles.bold12w500
                            .copyWith(color: Color(0xff6D6565))),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Container(
                width: 50,
                height: 50,
                color: Color(0xff134FA2),
                child: Center(
                  child: SvgPicture.asset(Assets.assetsPlus),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: TextStyles.bold16w500);
  }

  Widget _buildMedicineCard(String name, String dosage) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = MediaQuery.of(context).size.width;
        double iconSize = screenWidth * 0.022; // أيقونة دائرية متجاوبة
        double titleFontSize = screenWidth * 0.035; // حجم النص الأساسي
        double dosageFontSize = screenWidth * 0.022; // حجم الجرعة

        return Card(
          color: const Color(0xffe6f7fd),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.02, // تباعد رأسي ديناميكي
              horizontal: screenWidth * 0.04, // تباعد أفقي ديناميكي
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Icon(Icons.circle,
                      size: iconSize, color: const Color(0xff134FA2)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyles.bold12w400.copyWith(
                        fontSize: titleFontSize,
                        color: const Color(0xff134FA2),
                      ),
                    ),
                  ),
                  Text(
                    dosage,
                    style: TextStyles.bold9w400.copyWith(
                      fontSize: dosageFontSize,
                      color: const Color(0xff6D6565),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDoctorInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.75, // 3/4 العرض
          height: 1.3, // سمك الخط
          color: Colors.black, // لون الخط
          margin: const EdgeInsets.symmetric(vertical: 8), // تباعد رأسي
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // QR Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8), // حواف دائرية
              child: SvgPicture.asset(
                Assets.assetsQr,
                height: 40,
              ),
            ),
            const SizedBox(width: 12), // مسافة بين الـ QR والنص
            // Doctor Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Dr. Youssef Brosito",
                    style: TextStyles.bold6w500,
                  ),
                  Text("NO. 0123456789", style: TextStyles.bold6w500),
                  Text("Hospital / Clinic. Kaf El Sheikh General",
                      style: TextStyles.bold6w500),
                  Text(
                      "Address. In front of the Endowments Buildings - Kaf El Sheikh",
                      style: TextStyles.bold6w500),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}


//  children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           RichText(
//                             text: const TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: "Patient Name: ",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                   text: "Ahmed Ali",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           const Text("Age:   23",
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                           const Text("Gender:   Male",
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                           const Text("Report Date:   17-05-2024    20:18",
//                               style: TextStyle(fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],