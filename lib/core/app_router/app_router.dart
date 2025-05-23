import 'package:dentalog/Features/Splash/Widgets/Splash_view_body.dart';
import 'package:dentalog/Features/auth/presentation/views/Forget_your_password_view.dart';
import 'package:dentalog/Features/auth/presentation/views/auth_type_view.dart';
import 'package:dentalog/Features/auth/presentation/views/create_password_view.dart';
import 'package:dentalog/Features/auth/presentation/views/login_view.dart';
import 'package:dentalog/Features/auth/presentation/views/sign_up_view.dart';
import 'package:dentalog/Features/auth/presentation/views/type_user_view.dart';
import 'package:dentalog/Features/auth/presentation/views/verification_code_view.dart';
import 'package:dentalog/Features/home/presentation/views/Book_Appointment_view.dart';
import 'package:dentalog/Features/home/presentation/views/Notification_view.dart';
import 'package:dentalog/Features/home/presentation/views/appointment_view.dart';
import 'package:dentalog/Features/home/presentation/views/doctor_info_view.dart';
import 'package:dentalog/Features/home/presentation/views/doctor_view.dart';
import 'package:dentalog/Features/home/presentation/views/edit_profile_view.dart';
import 'package:dentalog/Features/home/presentation/views/history_view.dart';
import 'package:dentalog/Features/home/presentation/views/home_view.dart';
import 'package:dentalog/Features/home/presentation/views/new_password_view.dart';
import 'package:dentalog/Features/home/presentation/views/patient_detailes_view.dart';
import 'package:dentalog/Features/home/presentation/views/profile_view.dart';
import 'package:dentalog/Features/home/presentation/views/report_view.dart';
import 'package:dentalog/Features/home/presentation/views/write_report_view.dart';
import 'package:dentalog/Features/on_boarding/on_boarding_one_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kSplashView = '/Splashview';
  static const kOnboardingView = '/onboardingView';
  static const kTypeUserView = '/TypeUserView';
  static const kTypeAuthView = '/TypeAuthView';
  static const kSignUpView = '/SignUpView';
  static const kLoginView = '/LoginView';
  static const kForgetPasswordView = '/ForgetPasswordView';
  static const kVerificationCodeView = '/VerificationCodeView';
  static const kCreatePasswordView = '/CreatePasswordView';
  static const kHomeView = '/HomeView';
  static const kDoctorView = '/DoctorView';
  static const kDoctorInfoView = '/DoctorInfoView';
  static const kBookAppointmentView = '/BookAppointmentView';
  static const kappointmentView = '/appointmentView';
  static const kProfileView = '/profileView';
  static const kEditprofileView = '/editprofileView';
  static const kNewPasswordView = '/NewPasswordView';
  static const kNotificationView = '/NotificationView';
  static const kHistoryView = '/HistoryView';
  static const kReportView = '/ReportView';
  static const kWriteReportView = '/WriteReportView';
  static const kPatientDetailsView = '/PatientDetailsView';

  static GoRouter getRouter(String initialRoute) {
    return GoRouter(
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          path: kSplashView,
          builder: (context, state) => SplashViewBody(),
        ),
        GoRoute(
          path: kOnboardingView,
          builder: (context, state) => const OnBoardingOneView(),
        ),
        GoRoute(
          path: kTypeUserView,
          
          builder: (context, state) => const TypeUserView(),
        ),
        GoRoute(
          path: kTypeAuthView,
          pageBuilder: (context, state) {
            final type = state.extra as String;
            return MaterialPage(
              child: AuthTypeView(type: type),
            );
          },
        ),
       GoRoute(
          path: kSignUpView,
          pageBuilder: (context, state) {
            final type = state.extra as String;
            return MaterialPage(
              child: SignUpView(type: type),
            );
          },
        ),
        GoRoute(
          path: kLoginView,
          builder: (context, state) => const LoginView(),
        ),
        GoRoute(
          path: kForgetPasswordView,
          builder: (context, state) => const ForgetYourPasswordView(),
        ),
        GoRoute(
          path: kVerificationCodeView,
          builder: (context, state) => const VerificationCodeView(),
        ),
        GoRoute(
          path: kCreatePasswordView,
          builder: (context, state) => const CreatePasswordView(),
        ),
        GoRoute(
          path: kHomeView,
          builder: (context, state) => HomeView(),
        ),
        GoRoute(
          path: kDoctorView,
          builder: (context, state) => DoctorsView(),
        ),
        GoRoute(
          path: kDoctorInfoView,
          builder: (context, state) => DoctorInfoView(),
        ),
        GoRoute(
          path: kBookAppointmentView,
          builder: (context, state) => BookAppointmentView(),
        ),
        GoRoute(
          path: kappointmentView,
          builder: (context, state) => AppointmentView(),
        ),
        GoRoute(
          path: kProfileView,
          builder: (context, state) => ProfileView(),
        ),
        GoRoute(
          path: kEditprofileView,
          pageBuilder: (context, state) {
            final userData = state.extra as Map<String, dynamic>;
            return MaterialPage(
              child: EditProfileView(userData: userData),
            );
          },
        ),
        GoRoute(
          path: kNewPasswordView,
          builder: (context, state) => NewPasswordView(),
        ),
        GoRoute(
          path: kNotificationView,
          builder: (context, state) => NotificationView(),
        ),
        GoRoute(
          path: kHistoryView,
          builder: (context, state) => HistoryView(),
        ),
        GoRoute(
          path: kReportView,
          builder: (context, state) => ReportView(),
        ),
        GoRoute(
          path: kWriteReportView,
          builder: (context, state) => WriteReportView(),
        ),
        GoRoute(
          path: kPatientDetailsView,
          builder: (context, state) => PatientDetailesView(),
        ),
      ],
    );
  }
}
