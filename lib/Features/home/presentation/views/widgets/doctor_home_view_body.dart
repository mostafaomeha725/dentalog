import 'package:dentalog/Features/home/presentation/views/widgets/Custom_list_title.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/Custom_search_home.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/add_specialities.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class DoctorHomeViewBody extends StatelessWidget {
  const DoctorHomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomListTitle(),

          SizedBox(height: 16),


          CustomSearchHome(),
          SizedBox(height: 16),

          
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

List<Map<String, String>> specialities = [
  {"name": "Ophthalmology", "icon": Assets.assetsOphthalmology},
  {"name": "Dentist", "icon": Assets.assetsDentist},
  {"name": "Gastroenterology", "icon": Assets.assetsGastroenterology},
  {"name": "Neurology", "icon": Assets.assetsNeurology},
  {"name": "Radiography", "icon": Assets.assetsRadiography},
  {"name": "Nutrition", "icon": Assets.assetsNutrition},
  {"name": "Dermatology", "icon": Assets.assetsDermatology},
  {"name": "More", "icon": Assets.assetsMore},
];
