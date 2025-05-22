import 'package:dentalog/Features/home/presentation/views/widgets/build_report_card.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class HistoryViewBody extends StatelessWidget {
  const HistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                BuildReportCard(
                  doctor: "Dr. Kareem Ahmed",
                  title: "Report added for you",
                  time: "23h",
                  image: Assets.assetsDrKareem,
                  isNew: true,
                ),
                SizedBox(
                  height: 4,
                ),
                buildDivider(context),
                SizedBox(
                  height: 4,
                ),
                BuildReportCard(
                  doctor: "Dr. Kareem Ahmed",
                  title: "Report added for you",
                  time: "23h",
                  image: Assets.assetsDrKareem,
                ),
                BuildReportCard(
                  doctor: "Dr. Kareem Ahmed",
                  title: "Report added for you",
                  time: "23h",
                  image: Assets.assetsDrKareem,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: screenWidth * 0.05,
            endIndent: screenWidth * 0.02,
          ),
        ),
        Text(
          "New",
          style: TextStyles.bold10w300.copyWith(color: Colors.grey),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: screenWidth * 0.02, // 2% من عرض الشاشة
            endIndent: screenWidth * 0.05, // 5% من عرض الشاشة
          ),
        ),
      ],
    );
  }
}
