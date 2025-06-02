import 'package:dentalog/Features/home/presentation/views/widgets/Custom_list_title.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/Custom_search_home.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/add_specialities.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info
          CustomListTitle(),

          SizedBox(height: 16),

          // Search Bar

         // CustomSearchHome(),
          SizedBox(height: 16),

          // Medical Checks Banner
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xff134FA2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Medical Checks",
                      style: TextStyles.bold20w600inter
                          .copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Check you health condition regulary to\nminimize the incidence of disease in the future",
                      style:
                          TextStyles.bold10w400.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.kDoctorView);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45))),
                      child: Text("Check now",
                          style: TextStyles.bold16w600
                              .copyWith(color: Color(0xff134FA2))),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 36),
                  child: SvgPicture.asset(Assets.assetsRafiki),
                )
              ],
            ),
          ),

          SizedBox(height: 16),

          // Specialities Section
          Text("Speciality",
              style: TextStyles.bold19w600inter.copyWith(color: Colors.black)),

          SizedBox(height: 16),

          // Speciality Grid
         

         AddSpecialities(),
        ],
      ),
    );
  }
}


