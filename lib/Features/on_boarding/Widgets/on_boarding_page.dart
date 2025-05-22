import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title1;
  final String title2;

  const OnboardingPage(
      {required this.image, required this.title1, required this.title2});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: double.infinity,
          height: screenHeight * 0.55, // نصف الشاشة
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                bottom: screenHeight * 0.06, // 🔼 جعل التحريك نسبيًا
                child: SvgPicture.asset(
                  Assets.assetsbackgrounditemonboarding,
                  // width: screenWidth * 1.2, // جعل الحجم متناسبًا
                ),
              ),
              Positioned(
                bottom: 5,
                left: 0,
                right: 35,
                child: Image.asset(
                  image,
                  fit: BoxFit.fitHeight, // يحافظ على الصورة كاملة داخل الحاوية
                  height: 370, // تأكد أن الارتفاع مناسب
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.038),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title1,
              style: TextStyles.bold20w600,
            ),
            Text(
              title2,
              style: TextStyles.bold20w600,
            ),
          ],
        ),
      ],
    );
  }
}
