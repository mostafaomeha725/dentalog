import 'package:dentalog/Features/auth/presentation/manager/cubit/profile_cubit/profile_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/sign_up_cubit/signup_cubit.dart';
import 'package:dentalog/Features/auth/presentation/views/widgets/Login_Text.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_Text_field.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key, required this.type});
final String type ;
  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? phone;
  String? email;
  String? password;
  String? name;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignUpState>(
      listener: (context, state)  async{
        if (state is SignUpSuccess) {
                    GoRouter.of(context).push(AppRouter.kVerificationCodeView,extra: OtpArguments(phone!, email: email!, password: password!));

          _showSnackBar(context, "Registration successful");

        } else if (state is SignUpFailure) {
          _showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        final isLoading = state is SignUpLoading;
    
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
                    style:
                        TextStyles.bold20w600.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 64),
                  CustomTextField(
                    hint: "Full Name",
                    onChanged: (value) => name = value,
                    validator: (value) =>
                        value!.isEmpty ? "Full name is required" : null,
                    prefixIcon: Icon(Icons.person, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hint: "Phone",
                    onChanged: (value) => phone = value,
                    validator: (value) {
                      if (value!.isEmpty) return "Phone number is required";
                      return null;
                    },
                    prefixIcon: Icon(Icons.phone, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hint: "Email",
                    onChanged: (value) => email = value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      } else if (!value.contains("@") ||
                          !value.endsWith(".com")) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    prefixIcon: Icon(Icons.email, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hint: "Password",
                    active: true,
                    onChanged: (value) => password = value,
                    validator: (value) {
                      if (value!.isEmpty) return "Password is required";
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    prefixIcon: Icon(Icons.lock_outline_rounded,
                        color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 52),
                  CustomButtom(
                    text: isLoading ? "Signing Up..." : "Sign Up",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        context.read<SignupCubit>().registerUser(
                              email: email!,
                              password: password!,
                              name: name!,
                               mobile: phone!, user:widget.type ,

                            );
                      }
                    },
                    issized: true,
                  ),
                  const SizedBox(height: 48),
                  LoginText(
                    text: "Already have an account?  ",
                    textClick: "LogIn",
                    onTap: () =>
                        GoRouter.of(context).push(AppRouter.kLoginView),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        content: Text(message),
      ),
    );
  }
}
