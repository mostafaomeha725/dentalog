import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorCard extends StatelessWidget {
  final Map doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final user = doctor['user'];
    final speciality = doctor['speciality'];
    final imageUrl = 'https://your-base-url.com/${user['image']}'; // Replace base url

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and Availability
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 92,
                  height: 85,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.person, size: 85),
                ),
              ),
              SizedBox(height: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Next Available",
                      style: TextStyles.bold13w500.copyWith(color: Color(0xff134FA2))),
                  Text(
                    doctor['schedules'] != null && doctor['schedules'].isNotEmpty
                        ? doctor['schedules'][0]['start_time'].toString().substring(11, 16)
                        : 'N/A',
                    style: TextStyles.bold12w500.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 12),

          // Doctor Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user['name'], style: TextStyles.bold18w500),
                Text(
                  speciality['name'],
                  style: TextStyles.bold13w400.copyWith(color: Color(0xff134FA2)),
                ),
                Text(
                  user['phone'],
                  style: TextStyles.bold12w300.copyWith(color: Colors.grey),
                ),
             Row(
  children: List.generate(
    5,
    (index) => Icon(
      index < (num.tryParse(doctor['average_rating'].toString())?.round() ?? 0)
          ? Icons.star
          : Icons.star_border,
      color: Colors.amber,
      size: 16,
    ),
  ),
),


                SizedBox(height: 6),
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
                      GoRouter.of(context).push(AppRouter.kDoctorInfoView,extra: doctor);
                    },
                    child: Text(
                      "Book Now",
                      style: TextStyles.bold12w500.copyWith(color: Colors.white),
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
