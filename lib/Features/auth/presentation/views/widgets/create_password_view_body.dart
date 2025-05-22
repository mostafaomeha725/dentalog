import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_Text_field.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreatePasswordViewBody extends StatelessWidget {
  const CreatePasswordViewBody({super.key});

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
            "Create New Password",
            style: TextStyles.bold24w600,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Create your new password to login",
            style: TextStyles.bold16w500.copyWith(color: Colors.grey[700]),
          ),
          SizedBox(
            height: 32,
          ),
          CustomTextField(
            iscreatepass: true,
            hint: "Password",
            active: true,
            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              color: Colors.grey[700],
            ), // User icon
          ),
          SizedBox(height: 16),
          CustomTextField(
            iscreatepass: true,
            active: true,
            hint: "Confirm Password",
            prefixIcon: Icon(Icons.lock_outline_rounded,
                color: Colors.grey[700]), // User icon
          ),
          SizedBox(
            height: 54,
          ),
          CustomButtom(
            text: "Create Password",
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kHomeView);
            },
            issized: true,
          ),
        ],
      ),
    );
  }
}
