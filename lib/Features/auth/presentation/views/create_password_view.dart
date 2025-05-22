import 'package:dentalog/Features/auth/presentation/views/widgets/create_password_view_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreatePasswordView extends StatelessWidget {
  const CreatePasswordView({super.key});

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
      body: const CreatePasswordViewBody(),
    );
  }
}
