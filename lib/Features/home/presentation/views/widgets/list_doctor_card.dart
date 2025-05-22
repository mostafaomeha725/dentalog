import 'package:dentalog/core/utiles/app_images.dart';

class ListDoctorCard {
  static List<Map<String, dynamic>> categories = [
    {"label": "All", "icon": null},
    {"label": "Orthodontics", "icon": Assets.assetsNeurology},
    {
      "label": "Orthodontics",
      "icon": Assets.assetsDermatology,
    },
    {"label": "Toothache", "icon": Assets.assetsOphthalmology},
    {"label": "Orthodontics", "icon": Assets.assetsDentist},
    {"label": "Cleaning", "icon": Assets.assetsNutrition},
  ];

  static List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. Sohila Mostafa",
      "speciality": "Ophthalmology",
      "phone": "01012345678",
      "rating": 4.0,
      "image": Assets.assetsDrsohaila,
      "availableTime": "10:00 AM tomorrow"
    },
    {
      "name": "Dr. Kareem Ahmed",
      "speciality": "Ophthalmology",
      "phone": "01012345678",
      "rating": 3.2,
      "image": Assets.assetsDrKareem,
      "availableTime": "12:00 AM tomorrow"
    },
    {
      "name": "Dr. Ibraheem",
      "speciality": "Ophthalmology",
      "phone": "01012345678",
      "rating": 2.2,
      "image": Assets.assetsDribrahim,
      "availableTime": "Next Available"
    }
  ];
}
