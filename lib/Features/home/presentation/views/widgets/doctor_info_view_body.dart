import 'package:dentalog/Features/home/presentation/manager/cubit/doctor_rating_cubits/doctor_rating_cubit.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DoctorInfoViewBody extends StatefulWidget {
  const DoctorInfoViewBody({super.key, required this.doctor});
  final Map doctor;

  @override
  State<DoctorInfoViewBody> createState() => _DoctorInfoViewBodyState();
}

class _DoctorInfoViewBodyState extends State<DoctorInfoViewBody> {
  int _selectedRating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;
    final user = doctor['user'] ?? {};
    final doctorId = doctor['id'];
    final speciality = doctor['speciality'] ?? {};
    final schedules = doctor['schedules'] as List? ?? [];

    // ✅ تعديل هنا لمعالجة نوع التقييم
    final ratingValue = doctor['average_rating'];
    final rating = ratingValue is String
        ? double.tryParse(ratingValue) ?? 0.0
        : ratingValue is num
            ? ratingValue.toDouble()
            : 0.0;

    return BlocConsumer<DoctorRatingCubit, DoctorRatingState>(
      listener: (context, state) {
        if (state is DoctorRatingSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Rating submitted successfully')),
          );
          _reviewController.clear();
          setState(() => _selectedRating = 0);
        } else if (state is DoctorRatingFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Doctor Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
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
                          child: Image.network(
                            'https://your-base-url.com/${user['image'] ?? ''}',
                            width: 92,
                            height: 87,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dr. ${user['name'] ?? ''}",
                                style: TextStyles.bold18w600,
                              ),
                              Text(
                                speciality['name'] ?? '',
                                style: TextStyles.bold13w400.copyWith(
                                  color: const Color(0xff134FA2),
                                ),
                              ),
                              Text(
                                '${doctor['experience'] ?? 0} Years experience',
                                style: TextStyles.bold12w300.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    index < rating.floor()
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Phone Number
                    Text(
                      user['phone'] ?? '',
                      style: TextStyles.bold18w500.copyWith(
                        color: const Color(0xff134FA2),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Schedule
                    Text(
                      "Schedule",
                      style: TextStyles.bold16w500.copyWith(
                        color: const Color(0xff134FA2),
                      ),
                    ),
                    const SizedBox(height: 6),

                    ...schedules.map((s) {
                      final start = DateTime.tryParse(s['start_time'] ?? '');
                      final end = DateTime.tryParse(s['end_time'] ?? '');
                      final day = _dayOfWeekName(
                          int.tryParse(s['day_of_week']?.toString() ?? '1') ?? 1);
                      final startTime =
                          start != null ? "${start.hour}:00" : '';
                      final endTime = end != null ? "${end.hour}:00" : '';
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "$day: $startTime - $endTime",
                          style: TextStyles.bold13w400,
                        ),
                      );
                    }).toList(),

                    const SizedBox(height: 18),

                    // Evaluate doctor
                    Text(
                      "Evaluate doctor",
                      style: TextStyles.bold16w400.copyWith(
                        color: const Color(0xff134FA2),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: List.generate(
                        5,
                        (index) => IconButton(
                          icon: Icon(
                            index < _selectedRating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedRating = index + 1;
                            });
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: _reviewController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Write your review...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (state is DoctorRatingLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      CustomButtom(
                        text: "Submit Rating",
                        onPressed: () {
                          if (_selectedRating > 0 &&
                              _reviewController.text.isNotEmpty) {
                            context
                                .read<DoctorRatingCubit>()
                                .submitDoctorRating(
                                  doctorId: doctorId,
                                  rating: _selectedRating,
                                  review: _reviewController.text,
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please rate and write a review.",
                                ),
                              ),
                            );
                          }
                        },
                        issized: true,
                      ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),

              const Spacer(),

              // Book Now Button
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CustomButtom(
                  text: "Book Now",
                  onPressed: () {
                    GoRouter.of(context)
                        .push(AppRouter.kappointmentView, extra: doctorId);
                  },
                  issized: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _dayOfWeekName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "Unknown";
    }
  }
}
