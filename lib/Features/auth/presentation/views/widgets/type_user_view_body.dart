import 'package:dentalog/Features/auth/presentation/views/widgets/Custom_Buttom_Type_User.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TypeUserViewBody extends StatelessWidget {
  const TypeUserViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Column(
        children: [
          Image.asset(
            Assets.assetsDentistlogo1,
            width: 100,
            height: 100,
          ),
          SizedBox(
            height: 24,
          ),
          Text("Join As ",
              style: TextStyles.bold20w600.copyWith(color: Colors.black)),
        ],
      ),
      Column(
        children: [
          CustomButtonTypeUser(
              text: "User",
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kTypeAuthView,extra: "user");
              }),
          SizedBox(height: 24),
          CustomButtonTypeUser(
              text: "Doctor",
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kTypeAuthView,extra: 'doctor');
              }),
        //  SizedBox(height: 15),
          // CustomButtonTypeUser(
          //     text: "Admin",
          //     onPressed: () {
          //       GoRouter.of(context).push(AppRouter.kTypeAuthView,extra: 'admin');
          //     }),
        ],
      ),
      SizedBox(
        height: 60,
      ),
    ]);
  }
}
