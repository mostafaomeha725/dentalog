import 'package:dentalog/Features/auth/presentation/manager/cubit/edit_account_cubit/editprofile_cubit.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditableField extends StatefulWidget {
  final String label;
  final String fieldKey;
  final String initialValue;
  final Map<String, dynamic> userData;
  final bool isEditable;

  const EditableField({
    super.key,
    required this.label,
    required this.fieldKey,
    required this.initialValue,
    required this.userData,
    this.isEditable = true,
  });

  @override
  State<EditableField> createState() => EditableFieldState();
}

class EditableFieldState extends State<EditableField> {
  bool isEditing = false;
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _submitChange() async {
    final updatedValue = controller.text.trim();

    if (updatedValue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a value before saving.')),
      );
      return;
    }

    // تحقق طول كلمة المرور لو الحقل هو 'password'
    if (widget.fieldKey == 'password' && updatedValue.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 8 characters long.')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final storedId = prefs.getString('id');

    if (storedId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User ID not found.')),
      );
      return;
    }

    final updatedProfileData = {
      'id': storedId,
      'name': widget.fieldKey == 'name' ? updatedValue : (widget.userData['name'] ?? ''),
      'email': widget.fieldKey == 'email' ? updatedValue : (widget.userData['email'] ?? ''),
      'phone': widget.fieldKey == 'phone' ? updatedValue : (widget.userData['phone'] ?? ''),
      'password': widget.fieldKey == 'password' ? updatedValue : '',
      'role': widget.userData['role'] ?? 'user',
    };

    await context.read<EditprofileCubit>().editProfile(
          id: updatedProfileData['id'],
          name: updatedProfileData['name'],
          email: updatedProfileData['email'],
          phone: updatedProfileData['phone'],
          password: updatedProfileData['password'],
          role: updatedProfileData['role'],
        );

    setState(() {
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            widget.label,
            style: TextStyles.bold10w500.copyWith(color: const Color(0xff134FA2)),
          ),
          subtitle: isEditing
              ? TextField(
                  controller: controller,
                  decoration: const InputDecoration(border: InputBorder.none),
                  obscureText: widget.fieldKey == 'password',
                )
              : Text(
                  controller.text.isEmpty ? '********' : controller.text,
                  style: TextStyles.bold16w400.copyWith(color: const Color(0xff6D6565)),
                ),
          trailing: widget.isEditable
              ? IconButton(
                  icon: Icon(isEditing ? Icons.check : Icons.edit, color: Colors.grey),
                  onPressed: () {
                    if (isEditing) {
                      _submitChange();
                    } else {
                      setState(() {
                        isEditing = true;
                      });
                    }
                  },
                )
              : null,
        ),
      ),
    );
  }
}
