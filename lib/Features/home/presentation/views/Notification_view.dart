import 'package:dentalog/Features/home/presentation/manager/cubit/notification_cubit/notification_cubit.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/put_notifications_cubit/putnotification_cubit.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/notification_view_body.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotificationCubit>(
          create: (context) => NotificationCubit()..fetchNotifications(),
        ),
        BlocProvider<PutnotificationCubit>(
          create: (context) => PutnotificationCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xfff9f9f9),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xff134FA2)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Notifications",
            style: TextStyles.bold20w500,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: const NotificationViewBody(),
      ),
    );
  }
}
