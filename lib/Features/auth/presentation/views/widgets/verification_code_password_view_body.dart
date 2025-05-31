import 'package:dentalog/Features/auth/presentation/manager/cubit/forget_password_cubit/forgetpassword_cubit.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/verify_reset_password/verifyresetpassword_cubit.dart';
import 'package:dentalog/Features/auth/presentation/views/widgets/Login_Text.dart';
import 'package:dentalog/Features/auth/presentation/views/widgets/PinCode_Text_Field.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
class VerificationCodepasswordViewBody extends StatefulWidget {
  const VerificationCodepasswordViewBody({super.key, required this.phone, required this.type});
  final String phone;
    final String type;


  @override
  State<VerificationCodepasswordViewBody> createState() =>
      _VerificationCodepasswordViewBodyState();
}

class _VerificationCodepasswordViewBodyState
    extends State<VerificationCodepasswordViewBody> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocConsumer<VerifyresetpasswordCubit, VerifyresetpasswordState>(
        listener: (context, state) {
          if (!mounted) return;

          if (state is VerifyresetpasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          } else if (state is VerifyresetpasswordSuccess) {
               ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Verification successful!")),
            );
            final token = state.resetToken;

            // ✅ تأجيل التنقل بطريقة آمنة بعد انتهاء الـ frame الحالي
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;

              GoRouter.of(context).pushReplacement(
                AppRouter.kCreatePasswordView,
                extra: {
                  'token': token,
                  'phone': widget.phone,
                  'type':widget.type,
                },
              );
            });
          }
        },
        builder: (context, state) {
          if (state is VerifyresetpasswordLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text("Enter Verification Code", style: TextStyles.bold24w600),
                const SizedBox(height: 16),
                Text(
                  "Enter code that we sent to your\nnumber ${widget.phone}",
                  style: TextStyles.bold16w500.copyWith(color: Colors.grey[700]),
                ),
                const SizedBox(height: 32),
                PincodeTextFieldWidget(controller: _pinController),
                const SizedBox(height: 24),
                CustomButtom(
                  text: "Verify",
                  onPressed: () {
                    if (!mounted) return;

                    final code = _pinController.text.trim();
                    if (code.isNotEmpty) {
                      context.read<VerifyresetpasswordCubit>().verifyResetCode(
                            phone: widget.phone,
                            code: code,
                          );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter the verification code."),
                        ),
                      );
                    }
                  },
                  issized: true,
                ),
                const SizedBox(height: 16),
                LoginText(
                  text: "Don’t receive the code?  ",
                  textClick: "Resend",
                  onTap: () {
                    context
                          .read<ForgetpasswordCubit>()
                          .sendResetCode(phone: widget.phone);
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
