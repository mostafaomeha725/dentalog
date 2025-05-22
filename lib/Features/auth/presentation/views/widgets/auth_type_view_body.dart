import 'package:dentalog/Features/auth/presentation/views/widgets/Custom_buttom_sign_up.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthTypeViewBody extends StatelessWidget {
  const AuthTypeViewBody({super.key, required this.type});
final String type ;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Image.asset(
              Assets.assetsDentistlogo1,
              width: 100,
              height: 100,
            ),
            SizedBox(
              height: 24,
            ),
            Text("Let’s get started!",
                style: TextStyles.bold20w600.copyWith(color: Colors.black)),
          ],
        ),
        Container(
          color: Colors.white,
          height: 150,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Sign up to enjoy the features we’ve\nProvided, and stay healthy!",
              textAlign: TextAlign.center,
              style: TextStyles.bold16w500.copyWith(color: Color(0XFF6D6565)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CustomButtom(
                  text: "Login",
                  issized: true,
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kLoginView);
                  }),
              SizedBox(
                height: 12,
              ),
              CustomButtomSignUp(
                  text: "Sign Up",
                  onPressed: () {
                    GoRouter.of(context).push(AppRouter.kSignUpView,extra: type);
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
