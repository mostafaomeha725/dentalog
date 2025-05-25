import 'package:dentalog/Features/auth/presentation/manager/cubit/edit_account_cubit/editprofile_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/delete_account.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ... import statements ...
class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<EditprofileCubit, EditprofileState>(
      listener: (context, state) async {
        if (state is EditprofileSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم تعديل البيانات بنجاح')),
          );
          await context.read<ProfileCubit>().getProfile();
        } else if (state is EditprofileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('خطأ: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.18,
                    backgroundImage: AssetImage(Assets.assetsProfileAvater),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff6D6565B2),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildSectionTitle("المعلومات الشخصية"),
              _EditableField(
                label: "الاسم",
                fieldKey: "name",
                initialValue: userData['name'] ?? '',
                userData: userData,
              ),
              _EditableField(
                label: "البريد الإلكتروني",
                fieldKey: "email",
                initialValue: userData['email'] ?? '',
                userData: userData,
              ),
              _EditableField(
                label: "رقم الهاتف",
                fieldKey: "phone",
                initialValue: userData['phone'] ?? '',
                userData: userData,
              ),
              _EditableField(
                label: "كلمة المرور",
                fieldKey: "password",
                initialValue: '',
                userData: userData,
              ),
              SizedBox(height: screenHeight * 0.01),
              DeleteAccount(userData: userData),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyles.bold14w500,
        ),
      ),
    );
  }
}

class _EditableField extends StatefulWidget {
  final String label;
  final String fieldKey;
  final String initialValue;
  final Map<String, dynamic> userData;
  final bool isEditable;

  const _EditableField({
    required this.label,
    required this.fieldKey,
    required this.initialValue,
    required this.userData,
    this.isEditable = true,
  });

  @override
  State<_EditableField> createState() => _EditableFieldState();
}

class _EditableFieldState extends State<_EditableField> {
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
      const SnackBar(content: Text('الرجاء إدخال قيمة قبل الحفظ')),
    );
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  final storedId = prefs.getString('id'); 
  print(storedId);// تأكد أن المفتاح المستخدم هنا هو نفس المفتاح اللي خزنت به

  if (storedId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تعذر العثور على معرف المستخدم')),
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

