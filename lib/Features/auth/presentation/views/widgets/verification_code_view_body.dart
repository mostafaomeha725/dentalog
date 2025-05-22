import 'package:dentalog/Features/auth/presentation/views/widgets/Login_Text.dart';
import 'package:dentalog/Features/auth/presentation/views/widgets/PinCode_Text_Field.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerificationCodeViewBody extends StatefulWidget {
  const VerificationCodeViewBody({super.key});

  @override
  State<VerificationCodeViewBody> createState() =>
      _VerificationCodeViewBodyState();
}

class _VerificationCodeViewBodyState extends State<VerificationCodeViewBody> {
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Text(
            "Enter Verification Code",
            style: TextStyles.bold24w600,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Enter code that we sent to your\nnumber 0102299****",
            style: TextStyles.bold16w500.copyWith(color: Colors.grey[700]),
          ),
          SizedBox(
            height: 32,
          ),
          PincodeTextFieldWidget(
            controller: _pinController,
          ),
          CustomButtom(
            text: "Verify",
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kLoginView);
            },
            issized: true,
          ),
          LoginText(
            text: "Don’t receive the code?  ",
            textClick: "Resend",
          ),
        ],
      ),
    );
  }
}
