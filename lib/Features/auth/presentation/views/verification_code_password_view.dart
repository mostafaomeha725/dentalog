import 'package:dentalog/Features/auth/presentation/manager/cubit/profile_cubit/profile_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/sign_in_cubit/signin_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/verify_otp_cubit/verify_otp_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/reset_otp_cubit/reset_otp_cubit.dart'; // استيراد ResetOtpCubit
import 'package:dentalog/Features/auth/presentation/manager/cubit/verify_reset_password/verifyresetpassword_cubit.dart';
import 'package:dentalog/Features/auth/presentation/views/widgets/verification_code_password_view_body.dart';
import 'package:dentalog/Features/auth/presentation/views/widgets/verification_code_view_body.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
class VerificationCodePasswordView extends StatelessWidget {
  const VerificationCodePasswordView({
    super.key,
    required this.phone, required this.type,
  });

  final String phone;
    final String type;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: BlocProvider<VerifyresetpasswordCubit>(
        create: (context) => VerifyresetpasswordCubit(ApiService()),
        child: VerificationCodepasswordViewBody(
          phone: phone,
          type:type,
        ),
      ),
    );
  }
}
