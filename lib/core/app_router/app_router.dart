import 'package:dentalog/Features/Splash/Widgets/Splash_view_body.dart';
import 'package:dentalog/Features/auth/presentation/views/Forget_your_password_view.dart';
import 'package:dentalog/Features/auth/presentation/views/auth_type_view.dart';
import 'package:dentalog/Features/auth/presentation/views/create_password_view.dart';
import 'package:dentalog/Features/auth/presentation/views/login_view.dart';
import 'package:dentalog/Features/auth/presentation/views/sign_up_view.dart';
import 'package:dentalog/Features/auth/presentation/views/type_user_view.dart';
import 'package:dentalog/Features/auth/presentation/views/verification_code_password_view.dart';
import 'package:dentalog/Features/auth/presentation/views/verification_code_view.dart';
import 'package:dentalog/Features/home/presentation/views/Book_Appointment_view.dart';
import 'package:dentalog/Features/home/presentation/views/Notification_view.dart';
import 'package:dentalog/Features/home/presentation/views/appointment_view.dart';
import 'package:dentalog/Features/home/presentation/views/doctor_home_view.dart';
import 'package:dentalog/Features/home/presentation/views/doctor_info_view.dart';
import 'package:dentalog/Features/home/presentation/views/doctor_view.dart';
import 'package:dentalog/Features/home/presentation/views/edit_profile_view.dart';
import 'package:dentalog/Features/home/presentation/views/history_view.dart';
import 'package:dentalog/Features/home/presentation/views/home_view.dart';
import 'package:dentalog/Features/home/presentation/views/new_password_view.dart';
import 'package:dentalog/Features/home/presentation/views/patient_detailes_view.dart';
import 'package:dentalog/Features/home/presentation/views/profile_view.dart';
import 'package:dentalog/Features/home/presentation/views/report_view.dart';
import 'package:dentalog/Features/home/presentation/views/reschedule_appoinment_view.dart';
import 'package:dentalog/Features/home/presentation/views/show_specialties_doctor_view.dart';
import 'package:dentalog/Features/home/presentation/views/waiting_list_view.dart';
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
    static const kVerificationpasswordCodeView = '/VerificationpasswordCodeView';

  static const kCreatePasswordView = '/CreatePasswordView';
  static const kHomeView = '/HomeView';
    static const kDocrtorHomeView = '/DoctorHomeView';

  static const kDoctorView = '/DoctorView';
    static const kwaitingListview = '/waitingListview';

    static const kShowSpecialtiesDoctorView = '/ShowSpecialtiesDoctorView';

  static const kDoctorInfoView = '/DoctorInfoView';
  static const kBookAppointmentView = '/BookAppointmentView';
  static const kappointmentView = '/appointmentView';
    static const krescheduleappointmentView = '/rescheduleappointmentView';

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
          pageBuilder: (context, state) {
            final type = state.extra as String;
            return MaterialPage(
              child: LoginView(type: type),
            );
          },
        ),
        GoRoute(
          path: kForgetPasswordView,
          pageBuilder: (context, state) {
            final type = state.extra as String;
            return MaterialPage(
              child: ForgetYourPasswordView(type: type),
            );
          },
        ),
         GoRoute(
  path: kVerificationCodeView,
  builder: (context, state) {
    final args = state.extra as OtpArguments;
    return VerificationCodeView(
      phone: args.phone,
      email: args.email,
      password: args.password,
    );
  },
),

  GoRoute(
  path: kVerificationpasswordCodeView,
  builder: (context, state) {
    final args = state.extra as OtpArguments;
    return VerificationCodePasswordView(
      phone: args.phone, type: args.type!,
      

    );
  },
),

     GoRoute(
  path: AppRouter.kCreatePasswordView,
  builder: (context, state) {
    final extra = state.extra as Map<String, dynamic>;
    final String phone = extra['phone'];
    final String token = extra['token'];
    final String type =extra['type'];

    return CreatePasswordView(phone: phone, token: token,type:type);
  },
),

        GoRoute(
          path: kHomeView,
          builder: (context, state) => HomeView(),
        ),

 GoRoute(
          path: kDocrtorHomeView,
          builder: (context, state) => DoctorHomeView(),
        ),

        GoRoute(
          path: kDoctorView,
          builder: (context, state) => DoctorsView(),
        ),
        GoRoute(
          path: kDoctorInfoView,
          pageBuilder: (context, state) {
            final doctor = state.extra as Map;
            return MaterialPage(
              child: DoctorInfoView(doctor: doctor),
            );
          },
        ),
GoRoute(
  path: AppRouter.kBookAppointmentView,
  builder: (context, state) {
    final extra = state.extra as Map<String, dynamic>;
    final selectedDate = extra['selectedDate'] as DateTime;
    final selectedTime = extra['selectedTime'] as String;
        final doctorId = extra['DoctorId'] as int;


    return BookAppointmentView(
      selectedDate: selectedDate,
      selectedTime: selectedTime,
      doctorId:doctorId,
    );
  },
),


GoRoute(
  path: AppRouter.krescheduleappointmentView,
  pageBuilder: (context, state) {
    final extra = state.extra as Map<String, dynamic>;
    return MaterialPage(
      child: RescheduleAppoinmentView(
        doctorId: extra['doctorId'],
        appointmentId: extra['appointmentId'],
        isFromReschedule: extra['isFromReschedule'],
      ),
    );
  },
),


         GoRoute(
          path: kappointmentView,
          pageBuilder: (context, state) {
            final doctorId = state.extra as int;
            return MaterialPage(
              child: AppointmentView(doctorId: doctorId),
            );
          },
        ),
        GoRoute(
          path: kProfileView,
          builder: (context, state) => ProfileView(),
        ),
        GoRoute(
  path: kShowSpecialtiesDoctorView,
  pageBuilder: (context, state) {
    final data = state.extra as Map;
    final id = data['id'] as int;
    final name = data['name'] as String;

    return MaterialPage(
      child: ShowSpecialtiesDoctorView(id: id, name: name),
    );
  },
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
          pageBuilder: (context, state) {
            final type = state.extra as String;
            return MaterialPage(
              child: NewPasswordView(type: type,),
            );
          },
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
          pageBuilder: (context, state) {
            final id = state.extra as int;
            return MaterialPage(
              child: ReportView(id: id),
            );
          },
        ),
       GoRoute(
          path: kWriteReportView,
          pageBuilder: (context, state) {
            final id = state.extra as int;
            return MaterialPage(
              child: WriteReportView(id: id),
            );
          },
        ),
        GoRoute(
          path: kPatientDetailsView,
          builder: (context, state) => PatientDetailesView(),
        ),
          GoRoute(
          path: kwaitingListview,
          builder: (context, state) => WaitingListView(),
        ),
      ],
    );
  }
}


class OtpArguments {
  final String email;
  final String password;
  final String phone;
final String? type; 

  OtpArguments(this.type  ,this.phone, {required this.email, required this.password});
}
