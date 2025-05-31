// import 'package:dentalog/core/utiles/app_text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// class PincodeTextFieldWidget extends StatelessWidget {
//   const PincodeTextFieldWidget({super.key, this.controller});
//   final TextEditingController? controller;
//   @override
//  @override
// Widget build(BuildContext context) {
//   if (controller == null) return const SizedBox.shrink();

//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 22),
//     child: PinCodeTextField(
//       controller: controller,
//       length: 6,
//       appContext: context,
//       keyboardType: TextInputType.number,
//       textStyle: TextStyles.bold20w600,
//       pinTheme: PinTheme(
//         shape: PinCodeFieldShape.box,
//         borderRadius: BorderRadius.circular(8),
//         fieldHeight: 50,
//         fieldWidth: 50,
//         activeColor: const Color(0xff134FA2),
//         inactiveColor: const Color(0xff134FA2),
//         selectedColor: const Color(0xff134FA2),
//       ),
//     ),
//   );
// }

// }




import 'dart:math';

import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PincodeTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const PincodeTextFieldWidget({super.key, required this.controller});

  @override
  State<PincodeTextFieldWidget> createState() => _PincodeTextFieldWidgetState();
}

class _PincodeTextFieldWidgetState extends State<PincodeTextFieldWidget> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (_) => FocusNode());
    _controllers = List.generate(6, (_) => TextEditingController());

    for (int i = 0; i < 6; i++) {
      _controllers[i].addListener(() {
        final code = _controllers.map((c) => c.text).join();
        widget.controller.text = code;
      });
    }
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildBox(int index, double boxWidth) {
    return Container(
      width: boxWidth,
      height: boxWidth,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: TextStyles.bold20w600,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff134FA2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff134FA2), width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  @override
@override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final boxWidth = screenWidth/8.5 ;

  return FittedBox(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(6, (index) => _buildBox(index, boxWidth)),
      ),
    ),
  );
}

}