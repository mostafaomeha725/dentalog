import 'package:dentalog/Features/home/presentation/manager/cubit/notification_cubit/notification_cubit.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/put_notifications_cubit/putnotification_cubit.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationCubit, NotificationState>(
          listener: (context, state) {
            if (state is NotificationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
        ),
        BlocListener<PutnotificationCubit, PutnotificationState>(
          listener: (context, state) {
            if (state is PutnotificationFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            } else if (state is PutnotificationSuccess) {
              context.read<NotificationCubit>().fetchNotifications();
            }
          },
        ),
      ],
      child: BlocBuilder<NotificationCubit, NotificationState>(
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
                final isRead = notification["is_read"] == true;
                final imageUrl = notification["image"];

                return InkWell(
                  onTap: () async {
                    if (!isRead) {
                      context.read<PutnotificationCubit>().markAsRead(notification["id"]);
                    }

                    if (type == "report_added") {
                      GoRouter.of(context).push(AppRouter.kHistoryView);
                    } else if (type == "appointment_booked" || type == "status_changed") {
                      final role = await SharedPreference().getRole();

                      if (role == "doctor") {
                        GoRouter.of(context).push(AppRouter.kDoctorAppointmentTabView);
                      } else if (role == "user") {
                        GoRouter.of(context).push(AppRouter.kAppointmentTabView);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Unknown role")),
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: isRead ? Colors.white : Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        if (!isRead)
                          const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(Icons.circle, size: 8, color: Color(0xff134FA2)),
                          ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: _getImageProvider(imageUrl),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            notification["message"] ?? '',
                            style: TextStyles.bold12w500,
                          ),
                        ),
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

          return const SizedBox(); // Initial state
        },
      ),
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

  static ImageProvider _getImageProvider(String? url) {
    if (url != null && url.trim().isNotEmpty) {
      if (url.contains('optima-software-solutions.com/dentalog/https')) {
        url = url.replaceFirst('http://optima-software-solutions.com/dentalog/', '');
      }
      return NetworkImage(url);
    } else {
      return const AssetImage(Assets.assetsProfileAvater);
    }
  }
}
