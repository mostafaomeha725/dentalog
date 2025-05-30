import 'package:dentalog/Features/auth/presentation/manager/cubit/profile_cubit/profile_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/sign_in_cubit/signin_cubit.dart';
import 'package:dentalog/core/api/end_ponits.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dentalog/Features/auth/presentation/views/widgets/Login_Text.dart';
import 'package:dentalog/Features/auth/presentation/views/widgets/forget_password_text.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_Text_field.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:go_router/go_router.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key, required this.type});
final String type;
  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? password;
  String? phone;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SignInState>(
      listener: (context, state) async {
        if (state is SignInSuccess) {
          final prefs = await SharedPreferences.getInstance();

          // Save password
          await prefs.setString(ApiKey.password, password!);

          // Fetch profile data (which saves the role in SharedPreferences)
          // ignore: use_build_context_synchronously
          await context.read<ProfileCubit>().getProfile();

          // Get role from SharedPreferences
          final role = prefs.getString("role") ?? "";

          // Confirm role read
          debugPrint("Role from SharedPreferences: $role");

          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login successful")),
          );

          await Future.delayed(const Duration(milliseconds: 200));

          if (role == "doctor") {
            // ignore: use_build_context_synchronously
            GoRouter.of(context).pushReplacement(AppRouter.kDocrtorHomeView);
          } else if (role == "user") {
            // ignore: use_build_context_synchronously
            GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
          } else {
            // ignore: use_build_context_synchronously
            GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
          }
        } else if (state is SignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 70),
                  Image.asset(
                    Assets.assetsDentistlogo1,
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Let’s get started!",
                    style: TextStyles.bold20w600.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 64),
                  CustomTextField(
                    onSaved: (value) => phone = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Phone number is required";
                      } else if (!RegExp(r'^\d{9,15}$').hasMatch(value)) {
                        return "Please enter a valid phone number";
                      }
                      return null;
                    },
                    hint: "Phone Number",
                    prefixIcon:
                        Icon(Icons.phone_iphone_outlined, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    onSaved: (value) => password = value,
                    validator: (value) {
                      if (value!.isEmpty) return "Password is required";
                      return null;
                    },
                    hint: "Password",
                    active: true,
                    prefixIcon:
                        Icon(Icons.lock_outline_rounded, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 6),
                  const ForgetPasswordText(),
                  const SizedBox(height: 64),
                  state is SignInLoading
                      ? const CircularProgressIndicator()
                      : CustomButtom(
                          text: "Login",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              context.read<SigninCubit>().signInUser(
                                    phone: phone!,
                                    password: password!,
                                  );
                            }
                          },
                          issized: true,
                        ),
                  const SizedBox(height: 48),
                  LoginText(
                    text: "Don't have an account? ",
                    textClick: "Sign up now",
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kSignUpView,extra: widget.type);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
