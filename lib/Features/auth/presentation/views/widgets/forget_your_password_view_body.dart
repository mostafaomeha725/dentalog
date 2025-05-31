import 'package:dentalog/Features/auth/presentation/manager/cubit/forget_password_cubit/forgetpassword_cubit.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_Text_field.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgetYourPasswordViewBody extends StatefulWidget {
  const ForgetYourPasswordViewBody({super.key, required this.type});
final String type ;
  @override
  State<ForgetYourPasswordViewBody> createState() =>
      _ForgetYourPasswordViewBodyState();
}

class _ForgetYourPasswordViewBodyState
    extends State<ForgetYourPasswordViewBody> {
  String? phone;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetpasswordCubit, ForgetpasswordState>(
      listener: (context, state) {
        if (state is ForgetpasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
         
        } else if (state is ForgetpasswordSuccess) {
           GoRouter.of(context).push(AppRouter.kVerificationpasswordCodeView,extra: OtpArguments(widget.type,phone!, email: '', password: ''));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم إرسال الكود: ${state.resetCode}')),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ForgetpasswordLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  "Forget your password?",
                  style: TextStyles.bold24w600,
                ),
                const SizedBox(height: 16),
                Text(
                  "Enter your phone number, we will send you a verification code",
                  style: TextStyles.bold16w500.copyWith(color: Colors.grey[700]),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  onChanged: (value) {
                    phone = value;
                  },
                  hint: "Phone Number",
                  prefixIcon: Icon(Icons.phone, color: Colors.grey[700]),
                ),
                const SizedBox(height: 54),
                CustomButtom(
                  text: "Send Code",
                  onPressed: () {
                    if (phone != null && phone!.isNotEmpty) {
                      context
                          .read<ForgetpasswordCubit>()
                          .sendResetCode(phone: phone!);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter your phone number")),
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
