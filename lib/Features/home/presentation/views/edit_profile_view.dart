import 'package:dentalog/Features/auth/presentation/manager/cubit/edit_account_cubit/editprofile_cubit.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/edit_profile_view_body.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.userData});
  final Map<String, dynamic> userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xff134FA2)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          userData['name'],
          style: TextStyles.bold20w500,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => EditprofileCubit(
          ApiService()
        ),
        child: EditProfileViewBody(
          userData: userData,
        ),
      ),
    );
  }
}
