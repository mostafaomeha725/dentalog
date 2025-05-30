import 'package:dentalog/Features/auth/presentation/manager/cubit/profile_cubit/profile_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/reset_otp_cubit/reset_otp_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/sign_in_cubit/signin_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/verify_reset_password/verifyresetpassword_cubit.dart';
import 'package:dentalog/Features/auth/presentation/views/widgets/Login_Text.dart';
import 'package:dentalog/Features/auth/presentation/views/widgets/PinCode_Text_Field.dart';
import 'package:dentalog/core/api/end_ponits.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../manager/cubit/verify_otp_cubit/verify_otp_cubit.dart'; // تأكد من المسار الصحيح

class VerificationCodeViewBody extends StatefulWidget {
  const VerificationCodeViewBody({super.key, required this.email, required this.password, required this.phone});
  final String email;
  final String password;
  final String phone;
  @override
  State<VerificationCodeViewBody> createState() => _VerificationCodeViewBodyState();
}

class _VerificationCodeViewBodyState extends State<VerificationCodeViewBody> {
  final TextEditingController _pinController = TextEditingController();


  @override
 Widget build(BuildContext context) {
  return MultiBlocListener(
    listeners: [
      BlocListener<VerifyOtpCubit, VerifyOtpState>(
  listener: (context, state) async {
    if (state is VerifyOtpSuccess) {
      // تسجيل الدخول بعد التحقق من OTP
      await context.read<SigninCubit>().signInUser(
            phone: widget.phone,
            password: widget.password,
          );

      // استمع لنتيجة تسجيل الدخول
      context.read<SigninCubit>().stream.listen((signInState) async {
        if (signInState is SignInSuccess) {
          final prefs = await SharedPreferences.getInstance();

          // حفظ كلمة المرور
          await prefs.setString(ApiKey.password, widget.password);

          // جلب الملف الشخصي وتخزين الدور
          await context.read<ProfileCubit>().getProfile();

          final role = prefs.getString("role") ?? "";
          debugPrint("Role from SharedPreferences: $role");

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login successful")),
          );

          await Future.delayed(const Duration(milliseconds: 200));

          if (!mounted) return;

          if (role == "doctor") {
            GoRouter.of(context).pushReplacement(AppRouter.kDocrtorHomeView);
          } else {
            GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
          }
        } else if (signInState is SignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(signInState.errMessage)),
          );
        }
      });
    } else if (state is VerifyOtpFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("فشل التحقق: ${state.errMessage}")),
      );
    }
  },
),

      BlocListener<ResetOtpCubit, ResetOtpState>(
        listener: (context, state) {
          if (state is ResetOtpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ResetOtpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("فشل إرسال الكود: ${state.errMessage}")),
            );
          }
        },
      ),
    ],
    child: BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text("Enter Verification Code", style: TextStyles.bold24w600),
              SizedBox(height: 16),
              Text(
                "Enter code that we sent to your\nnumber 0102299****",
                style: TextStyles.bold16w500.copyWith(color: Colors.grey[700]),
              ),
              SizedBox(height: 32),
              PincodeTextFieldWidget(controller: _pinController),
              SizedBox(height: 24),
              state is VerifyOtpLoading
                  ? Center(child: CircularProgressIndicator())
                  : CustomButtom(
                      text: "Verify",
                      onPressed: () {
                        final otp = _pinController.text.trim();
                        if (otp.length < 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("يرجى إدخال رمز مكون من 6 أرقام")),
                          );
                          return;
                        }
                        context.read<VerifyOtpCubit>().verifyOtp(
                              email: widget.email,
                              otp: otp,
                            );
                      },
                      issized: true,
                    ),
              SizedBox(height: 16),
              BlocBuilder<ResetOtpCubit, ResetOtpState>(
                builder: (context, resetState) {
                  return LoginText(
                    text: "Don’t receive the code?  ",
                    textClick: resetState is ResetOtpLoading ? "Sending..." : "Resend",
                    onTap: resetState is! ResetOtpLoading
                        ? () {
                            context.read<ResetOtpCubit>().resetOtp(
                                  email: widget.email,
                                );
                          }
                        : null,
                  );
                },
              ),
            ],
          ),
        );
      },
    ),
  );
}
}





