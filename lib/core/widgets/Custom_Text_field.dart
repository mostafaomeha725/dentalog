import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.active = false,
    this.isNum = false,
    this.iscreatepass = false,
    this.controller,
    this.validator,
    this.onSaved,
    this.onChanged,
  });

  final String hint;
  final Widget? prefixIcon;
  final bool active;
  final bool isNum;
  final bool iscreatepass;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = false; // ✅ نقلها داخل State لضمان استقلال كل حقل

  @override
  void initState() {
    super.initState();
    _isObscured = widget.active; // ✅ التأكد من أن القيمة تبدأ وفقًا لـ `active`
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      validator: widget.validator,
      onSaved: widget.onSaved,
      controller: widget.controller,
      obscureText: widget.active ? _isObscured : false, // ✅ التحقق الصحيح
      decoration: InputDecoration(
        suffixIcon: widget.active
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[700],
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
        contentPadding: EdgeInsets.symmetric(vertical: 18),
        hintText: widget.hint,
        hintStyle: TextStyles.bold18w500.copyWith(color: Colors.grey[700]),
        prefixIcon: widget.prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color(0xff134FA2),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: widget.iscreatepass ? Color(0xff0A828A) : Color(0xff134FA2),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color(0xff134FA2),
            width: 2,
          ),
        ),
      ),
    );
  }
}
