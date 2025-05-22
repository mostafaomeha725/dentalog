import 'package:dentalog/Features/auth/presentation/manager/cubit/sign_up_cubit/signup_cubit.dart';
import 'package:dentalog/Features/auth/presentation/views/widgets/sign_up_view_body.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key, required this.type});
final String type ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(ApiService(),SharedPreference()),
      child: Scaffold(
        body: SignUpViewBody(type:type),
      ),
    );
  }
}
