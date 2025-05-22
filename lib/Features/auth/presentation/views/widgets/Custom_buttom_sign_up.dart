import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomButtomSignUp extends StatelessWidget {
  const CustomButtomSignUp(
      {super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: Color(0xff134FA2)),
        ),
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyles.bold20w600.copyWith(color: Color(0xff134FA2)),
      ),
    );
  }
}
