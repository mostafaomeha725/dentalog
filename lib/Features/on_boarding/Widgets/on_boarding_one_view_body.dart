import 'package:dentalog/Features/on_boarding/Widgets/on_boarding_page.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingOneViewBody extends StatelessWidget {
  final PageController _pageController = PageController();

  OnBoardingOneViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              OnboardingPage(
                image: Assets.assetsUnsplashMan1,
                title1: "Consult only with a doctor",
                title2: " you trus",
              ),
              OnboardingPage(
                image: Assets.assetsUnsplashWoman,
                title1: "Schedule Appointment With ",
                title2: "Expert Doctor’s",
              ),
              OnboardingPage(
                image: Assets.assetsUnsplashPhone,
                title1: "Book your appointments easily",
                title2: " and without wasting time",
              ),
            ],
          ),
          Positioned(
            top: 60,
            right: 0,
            child: TextButton(
              onPressed: () {
                _pageController.jumpToPage(2); // تخطي إلى آخر صفحة
              },
              child: Text("Skip",
                  style:
                      TextStyles.bold16w500.copyWith(color: Color(0XFF134FA2))),
            ),
          ),
          Positioned(
            bottom: 160,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.blue,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 20,
            right: 20,
            child: CustomButtom(
              text: "Next",
              onPressed: () {
                if (_pageController.page == 2) {
                  GoRouter.of(context).pushReplacement(AppRouter.kTypeUserView);
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
