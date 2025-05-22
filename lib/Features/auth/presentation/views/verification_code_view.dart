import 'package:dentalog/Features/auth/presentation/views/widgets/verification_code_view_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerificationCodeView extends StatelessWidget {
  const VerificationCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () => GoRouter.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff134FA2),
          ),
        ),
      ),
      body: VerificationCodeViewBody(),
    );
  }
}
