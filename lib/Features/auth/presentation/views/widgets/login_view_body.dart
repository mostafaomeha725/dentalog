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
  const LoginViewBody({super.key});

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

          await prefs.setString(ApiKey.password, password!);

          // جلب بيانات البروفايل
          await context.read<ProfileCubit>().getProfile();

          // الحصول على بيانات المستخدم من ProfileCubit
          final profileState = context.read<ProfileCubit>().state;

          String? role;

          if (profileState is ProfileSuccess) {
            // جلب الدور من بيانات المستخدم
            role = profileState.profileData['user']['role'] as String?;

            if (role != null) {
              // تخزين الدور في SharedPreferences
              await prefs.setString('role', role);
            }
          } else {
            // لو لم يتوفر دور من البروفايل حاول تقراه من SharedPreferences
            role = prefs.getString('role');
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تم تسجيل الدخول بنجاح")),
          );
          await Future.delayed(const Duration(milliseconds: 200));

          // التنقل بناءً على الدور
          if (role == 'doctor') {
            GoRouter.of(context).pushReplacement(AppRouter.kDocrtorHomeView);
          } else if (role == 'user') {
            GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
          } else {
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
                        return "رقم الهاتف مطلوب";
                      } else if (!RegExp(r'^\d{9,15}$').hasMatch(value)) {
                        return "يرجى إدخال رقم هاتف صحيح";
                      }
                      return null;
                    },
                    hint: "رقم الهاتف",
                    prefixIcon: Icon(Icons.phone_iphone_outlined, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    onSaved: (value) => password = value,
                    validator: (value) {
                      if (value!.isEmpty) return "كلمة المرور مطلوبة";
                      return null;
                    },
                    hint: "كلمة المرور",
                    active: true,
                    prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 6),
                  const ForgetPasswordText(),
                  const SizedBox(height: 64),
                  state is SignInLoading
                      ? const CircularProgressIndicator()
                      : CustomButtom(
                          text: "تسجيل الدخول",
                          onPressed: () async {
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
                    text: "ليس لديك حساب؟ ",
                    textClick: "سجل الآن",
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kSignUpView);
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
