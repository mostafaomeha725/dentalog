import 'package:dentalog/Features/auth/presentation/manager/cubit/forget_password_cubit/forgetpassword_cubit.dart';
import 'package:dentalog/Features/auth/presentation/views/widgets/forget_your_password_view_body.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetYourPasswordView extends StatelessWidget {
  const ForgetYourPasswordView({super.key, required this.type});
final String type ;
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
      body:  ForgetYourPasswordViewBody(
        type:type,
      ),
    );
  }
}
