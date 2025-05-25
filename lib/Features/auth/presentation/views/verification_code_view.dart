import 'package:dentalog/Features/auth/presentation/manager/cubit/profile_cubit/profile_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/sign_in_cubit/signin_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/verify_otp_cubit/verify_otp_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/reset_otp_cubit/reset_otp_cubit.dart'; // استيراد ResetOtpCubit
import 'package:dentalog/Features/auth/presentation/views/widgets/verification_code_view_body.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class VerificationCodeView extends StatelessWidget {
  const VerificationCodeView({
    super.key,
    required this.email,
    required this.password,
    required this.phone,
  });

  final String email;
  final String password;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VerifyOtpCubit>(
          create: (context) => VerifyOtpCubit(ApiService()),
        ),
        BlocProvider<SigninCubit>(
          create: (context) => SigninCubit(
            ApiService(),
            ProfileCubit(ApiService(), SharedPreference()),
            SharedPreference(),
          ),
        ),
        BlocProvider<ResetOtpCubit>(  // إضافة ResetOtpCubit هنا
          create: (context) => ResetOtpCubit(ApiService()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () => GoRouter.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff134FA2),
            ),
          ),
        ),
        body: VerificationCodeViewBody(
          email: email,
          password: password,
          phone: phone,
        ),
      ),
    );
  }
}
