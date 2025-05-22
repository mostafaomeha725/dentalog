import 'package:dentalog/Features/auth/presentation/manager/cubit/delete_account_cubit/delete_account_cubit.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key,required this.userData});
final Map<String,dynamic> userData ;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
  create: (context) => DeleteAccountCubit(ApiService(), SharedPreference()),
  child: BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
    listener: (context, state) {
      if (state is DeleteAccountSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("تم حذف الحساب بنجاح")),
        );
        GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
      } else if (state is DeleteAccountFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    },
    builder: (context, state) {
      return Align(
        alignment: Alignment.bottomLeft,
        child: TextButton.icon(
          onPressed: state is DeleteAccountLoading
              ? null
              : () async {
                  final userId = userData['id'];
                  if (userId != null) {
                    context
                        .read<DeleteAccountCubit>()
                        .deleteAccount(int.parse(userId));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("لم يتم العثور على معرف المستخدم")),
                    );
                  }
                },
          icon: const Icon(Icons.delete, color: Colors.red),
          label: state is DeleteAccountLoading
              ? const SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.red,
                  ),
                )
              : Text(
                  "Delete Account",
                  style: TextStyles.bold12w500.copyWith(color: Colors.red),
                ),
        ),
      );
    },
  ),
)
;
  }
}