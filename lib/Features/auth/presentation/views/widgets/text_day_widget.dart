import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class TextDayWidget extends StatelessWidget {
  const TextDayWidget({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1, // First part (bold)
            style: TextStyles.bold14w400.copyWith(
              color: Color(
                0xff6D6565,
              ),
            ),
          ),
          TextSpan(
            text: text2, // Second part (smaller)
            style: TextStyles.bold10w400.copyWith(
              color: Color(
                0xff6D6565,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
