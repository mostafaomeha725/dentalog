import 'package:dentalog/core/api/end_ponits.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

Future<void> _navigateToNextScreen() async {
  final prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  await Future.delayed(const Duration(seconds: 3));

  if (isFirstTime) {
    await prefs.setBool('isFirstTime', false);
    // ignore: use_build_context_synchronously
    GoRouter.of(context).pushReplacement(AppRouter.kOnboardingView);
    return; // عشان يوقف هنا وما ينفذ الباقي
  }
    String? id = await SharedPreference().getUser(ApiKey.id);

 

  if (id == null) {
    // ignore: use_build_context_synchronously
    GoRouter.of(context).pushReplacement(AppRouter.kTypeUserView);
  } else {
    // ignore: use_build_context_synchronously
    GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.assetsDentistlogo1),
            Text(
              "Dentalog",
              style: TextStyles.bold30w400
                  .copyWith(color: const Color(0xff134FA2)),
            ),
          ],
        ),
      ),
    );
  }
}
