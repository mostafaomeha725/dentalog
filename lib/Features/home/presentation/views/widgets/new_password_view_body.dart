import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewPasswordViewBody extends StatefulWidget {
  const NewPasswordViewBody({super.key});

  @override
  _NewPasswordViewBodyState createState() => _NewPasswordViewBodyState();
}

class _NewPasswordViewBodyState extends State<NewPasswordViewBody> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.02),

          // تعليمات
          Text(
            "To set a new password, please enter your current password first.",
            style: TextStyles.bold16w400.copyWith(color: Color(0xff6D6565)),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: screenHeight * 0.04),

          // حقل إدخال كلمة المرور
          TextField(
            obscureText: _isObscure,
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle:
                  TextStyles.bold14w400.copyWith(color: Color(0xffD9D9D9)),
              // prefixIcon: const Icon(Icons.lock, color: Colors.green),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),
              border: const UnderlineInputBorder(),
            ),
          ),

          SizedBox(height: screenHeight * 0.01),

          // رابط نسيان كلمة المرور
          Center(
            child: TextButton(
              onPressed: () {
                // وظيفة استرجاع كلمة المرور
              },
              child: GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kHistoryView);
                },
                child: Text(
                  "Forgot Your Password?",
                  style:
                      TextStyles.bold10w400.copyWith(color: Color(0xff134FA2)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
