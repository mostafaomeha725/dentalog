import 'package:dentalog/Features/home/presentation/manager/cubit/notification_cubit/notification_cubit.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state is NotificationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        if (state is NotificationLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is NotificationSuccess) {
          final notifications = state.notificationsData;

          if (notifications.isEmpty) {
            return const Center(child: Text("No notifications found."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final type = notification["type"];

              return InkWell(
                onTap: () {
                  if (type == "report_added") {
                    GoRouter.of(context).push(AppRouter.kHistoryView);
                  } else if (type == "appointment_booked") {
                    //GoRouter.of(context).push(AppRouter.kBookAppointmentView);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: notification["is_read"] ? Colors.white : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      if (!notification["is_read"])
                        const Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Icon(Icons.circle, size: 8, color: Color(0xff134FA2)),
                        ),
                      const SizedBox(width: 8),

                      // Placeholder avatar (customize as needed)
                      const CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage(Assets.assetsDribrahim),
                      ),
                      const SizedBox(width: 12),

                      // Notification message
                      Expanded(
                        child: Text(
                          notification["message"] ?? '',
                          style: TextStyles.bold12w500,
                        ),
                      ),

                      // Notification time
                      Text(
                        _formatTime(notification["created_at"]),
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        if (state is NotificationFailure) {
          return Center(child: Text("Error: ${state.errorMessage}"));
        }

        return const SizedBox(); // Default (initial) state
      },
    );
  }

  static String _formatTime(String? isoTime) {
    if (isoTime == null) return '';
    final dateTime = DateTime.tryParse(isoTime);
    if (dateTime == null) return '';
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }
}
