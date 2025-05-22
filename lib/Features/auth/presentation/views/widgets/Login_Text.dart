import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginText extends StatelessWidget {
  const LoginText(
      {super.key, required this.text, required this.textClick, this.onTap});
  final String text;
  final String textClick;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: text,
          style: TextStyles.bold14w500.copyWith(color: Colors.grey[700]),
          children: [
            TextSpan(
              text: textClick,
              style: TextStyles.bold14w500.copyWith(color: Color(0xff134FA2)),
              // اجعل النص قابلاً للنقر
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
