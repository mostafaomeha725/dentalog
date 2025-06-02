import 'dart:io';

import 'package:dentalog/Features/auth/presentation/manager/cubit/edit_account_cubit/editprofile_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/profile_cubit/profile_cubit.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/editable_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/delete_account.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  File? selectedImage;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final image = File(picked.path);
      setState(() {
        selectedImage = image;
      });

      final prefs = await SharedPreferences.getInstance();
      final storedId = prefs.getString('id');

      if (storedId != null) {
        await context.read<EditprofileCubit>().editProfile(
              id: storedId,
              name: widget.userData['name'],
              email: widget.userData['email'],
              phone: widget.userData['phone'],
              password: '',
              role: widget.userData['role'] ?? 'user',
              imageFile: image,
            );
      }
    }
  }

  ImageProvider _getImageProvider(String? imageUrl) {
    if (imageUrl != null && imageUrl.trim().isNotEmpty) {
      // معالجة الرابط الخاطئ إن وُجد
      if (imageUrl.contains('optima-software-solutions.com/dentalog/https')) {
        imageUrl = imageUrl.replaceFirst(
            'http://optima-software-solutions.com/dentalog/', '');
      }

      return NetworkImage(imageUrl);
    } else {
      return const AssetImage(Assets.assetsProfileAvater);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<EditprofileCubit, EditprofileState>(
      listener: (context, state) async {
        if (state is EditprofileSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('The data has been successfully modified.')),
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
                    backgroundImage: selectedImage != null
                        ? FileImage(selectedImage!)
                        : _getImageProvider(widget.userData['image']),
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
                      onPressed: _pickImage,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildSectionTitle("personal information"),
              EditableField(
                label: "Name",
                fieldKey: "name",
                initialValue: widget.userData['name'] ?? '',
                userData: widget.userData,
              ),
              EditableField(
                label: "Email",
                fieldKey: "email",
                initialValue: widget.userData['email'] ?? '',
                userData: widget.userData,
              ),
              EditableField(
                label: "Phone Number",
                fieldKey: "phone",
                initialValue: widget.userData['phone'] ?? '',
                userData: widget.userData,
              ),
              EditableField(
                label: "Password",
                fieldKey: "password",
                initialValue: '',
                userData: widget.userData,
              ),
              
              SizedBox(height: 12),
              DeleteAccount(userData: widget.userData),
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
  