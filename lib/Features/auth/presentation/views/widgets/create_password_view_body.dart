import 'package:dentalog/Features/auth/presentation/manager/cubit/reset_password_cubit/resetpassword_cubit.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_Text_field.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreatePasswordViewBody extends StatefulWidget {
  const CreatePasswordViewBody({
    super.key,
    required this.token,
    required this.phone,
  });

  final String token;
  final String phone;

  @override
  State<CreatePasswordViewBody> createState() => _CreatePasswordViewBodyState();
}

class _CreatePasswordViewBodyState extends State<CreatePasswordViewBody> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetpasswordCubit, ResetpasswordState>(
      listener: (context, state) {
        if (state is ResetpasswordSuccess) {
          GoRouter.of(context).push(AppRouter.kLoginView);
        } else if (state is ResetpasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              top: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Create New Password", style: TextStyles.bold24w600),
                const SizedBox(height: 16),
                Text(
                  "Create your new password to login",
                  style: TextStyles.bold16w500.copyWith(color: Colors.grey[700]),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _passwordController,
                  iscreatepass: true,
                  hint: "Password",
                  active: true,
                  prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.grey[700]),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _confirmPasswordController,
                  iscreatepass: true,
                  hint: "Confirm Password",
                  active: true,
                  prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.grey[700]),
                ),
                const SizedBox(height: 54),
                state is ResetpasswordLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButtom(
                        text: "Create Password",
                        onPressed: () {
                          final password = _passwordController.text.trim();
                          final confirmPassword = _confirmPasswordController.text.trim();

                          if (password.isEmpty || confirmPassword.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please fill all fields")),
                            );
                          } else if (password != confirmPassword) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Passwords do not match")),
                            );
                          } else {
                            context.read<ResetpasswordCubit>().resetPassword(
                                  phone: widget.phone,
                                  token: widget.token,
                                  password: password,
                                );
                          }
                        },
                        issized: true,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
