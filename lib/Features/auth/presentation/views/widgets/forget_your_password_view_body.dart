
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_Text_field.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgetYourPasswordViewBody extends StatefulWidget {
  const ForgetYourPasswordViewBody({super.key, this.isLoading = false});

  final bool isLoading;
  @override
  State<ForgetYourPasswordViewBody> createState() =>
      _ForgetYourPasswordViewBodyState();
}

class _ForgetYourPasswordViewBodyState
    extends State<ForgetYourPasswordViewBody> {
  String? email;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: widget.isLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              "Forget your password?",
              style: TextStyles.bold24w600,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Enter your phone number,we will send you configaration code",
              style: TextStyles.bold16w500.copyWith(color: Colors.grey[700]),
            ),
            SizedBox(
              height: 32,
            ),
            CustomTextField(
              //   isNum: true,
              //   active: true,
              onChanged: (value) {
                email = value;
              },
              hint: "Email",
              prefixIcon:
                  Icon(Icons.email, color: Colors.grey[700]), // User icon
            ),
            SizedBox(
              height: 54,
            ),
            CustomButtom(
              text: "Send Code",
              onPressed: () {
               
              },
              issized: true,
            ),
          ],
        ),
      ),
    );
  }
}
