import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kForgetPasswordView);
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "Forget Password ?",
          style: TextStyles.bold13w400.copyWith(color: Colors.grey[700]),
        ),
      ),
    );
  }
}
