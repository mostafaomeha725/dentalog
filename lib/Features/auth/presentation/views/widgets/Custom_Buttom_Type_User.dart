import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomButtonTypeUser extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButtonTypeUser(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15),
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Color(0xff134FA2)),
          ),
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyles.bold20w600.copyWith(color: Color(0xff134FA2)),
        ),
      ),
    );
  }
}
