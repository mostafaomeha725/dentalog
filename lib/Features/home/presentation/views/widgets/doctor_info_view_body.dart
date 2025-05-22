import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorInfoViewBody extends StatelessWidget {
  const DoctorInfoViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return // Background color

        Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Doctor Card
          Container(
            padding: EdgeInsets.all(16),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Doctor Image and Name
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        Assets.assetsDrsohaila, // Change to your asset path
                        width: 92,
                        height: 87,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dr. Sohila Mostafa",
                          style: TextStyles.bold18w600,
                        ),
                        Text(
                          "Tooths Dentist",
                          style: TextStyles.bold13w400
                              .copyWith(color: Color(0xff134FA2)),
                        ),
                        Text(
                          "7 Years experience",
                          style: TextStyles.bold12w300
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < 4 ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Phone Number
                Text(
                  "01083838439",
                  style:
                      TextStyles.bold18w500.copyWith(color: Color(0xff134FA2)),
                ),

                SizedBox(height: 10),

                // Schedule
                Text(
                  "Schedule",
                  style:
                      TextStyles.bold16w500.copyWith(color: Color(0xff134FA2)),
                ),

                //     TextDayWidget(text1: 'Thursday: ', text2: '10Am : 3PM'),
                SizedBox(
                  height: 6,
                ),
                //   TextDayWidget(text1: 'Saturday: ', text2: '12Pm : 8PM'),
                SizedBox(
                  height: 6,
                ),
                // TextDayWidget(text1: 'Monday: ', text2: '8Am : 4PM'),

                SizedBox(height: 18),

                // Evaluate Doctor
                Text(
                  "Evaluate doctor",
                  style: TextStyles.bold16w400.copyWith(
                    color: Color(
                      0xff134FA2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                // Star Rating for Evaluation
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 42,
                ),
              ],
            ),
          ),

          Spacer(),

          // Book Now Button
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CustomButtom(
              text: "Book Now",
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kappointmentView);
              },
              issized: true,
            ),
          ),
        ],
      ),
    );
  }
}
