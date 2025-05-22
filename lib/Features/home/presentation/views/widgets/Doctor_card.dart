import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorCard({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // لجعل الصورة تبدأ من الأعلى
        children: [
          // صورة الطبيب و "Next Available"
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  doctor['image'],
                  width: 92,
                  height: 85,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 6),
              // "Next Available" تحت الصورة مباشرة
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Next Available",
                      style: TextStyles.bold13w500
                          .copyWith(color: Color(0xff134FA2))),
                  Text(
                    doctor['availableTime'],
                    style: TextStyles.bold12w500.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 12),

          // تفاصيل الطبيب
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor['name'],
                  style: TextStyles.bold18w500,
                ),
                Text(
                  doctor['speciality'],
                  style:
                      TextStyles.bold13w400.copyWith(color: Color(0xff134FA2)),
                ),
                Text(
                  doctor['phone'],
                  style: TextStyles.bold12w300.copyWith(color: Colors.grey),
                ),

                // تصنيف النجوم
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < doctor['rating'].toInt()
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    ),
                  ),
                ),

                SizedBox(height: 6),

                // زر الحجز
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff134FA2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.kDoctorInfoView);
                    },
                    child: Text(
                      "Book Now",
                      style:
                          TextStyles.bold12w500.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
