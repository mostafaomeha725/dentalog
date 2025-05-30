import 'package:dentalog/Features/auth/presentation/manager/cubit/profile_cubit/profile_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/sign_in_cubit/signin_cubit.dart';
import 'package:dentalog/Features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key, required this.type});
final String type ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(ApiService(),ProfileCubit(
       ApiService(), SharedPreference()
      ),
      SharedPreference(),
      ),
      child: Scaffold(
        body: LoginViewBody(type:type),
      ),
    );
  }
}
