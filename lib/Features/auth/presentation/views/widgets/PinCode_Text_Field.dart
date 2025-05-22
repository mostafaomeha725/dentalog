import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PincodeTextFieldWidget extends StatelessWidget {
  const PincodeTextFieldWidget({super.key, this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: PinCodeTextField(
        controller: controller,
        length: 6,
        appContext: context,
        keyboardType: TextInputType.number,
        textStyle: TextStyles.bold20w600,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8),
          fieldHeight: 50,
          fieldWidth: 50,
          activeColor: Color(0xff134FA2),
          inactiveColor: Color(0xff134FA2),
          selectedColor: Color(0xff134FA2),
        ),
      ),
    );
  }
}
