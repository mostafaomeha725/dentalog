import 'package:dentalog/Features/auth/presentation/manager/cubit/profile_cubit/profile_cubit.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/show_Appointments_cubit/show_appointments_cubit.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/show_Specialties_by_id_cubit/show_specialtiesbyid_cubit.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/show_doctor_cubit/showdoctor_cubit.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/show_specialties_cubit/show_specialties_cubit.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/update_ppointment_status_cubit/updateappointmentstatus_cubit.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/waiting_list_cubit/waitinglist_cubit.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/helper/BlocObserve/Simple_Bloc_Observe.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dentalog/core/services/api_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   Bloc.observer = SimpleBlocObserve();


runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit( ApiService(),SharedPreference())..getProfile(),
        ),
         BlocProvider<ShowSpecialtiesCubit>(
          create: (context) => ShowSpecialtiesCubit( ApiService())..showSpecialties(),
        ),
         BlocProvider<ShowdoctorCubit>(
          create: (context) => ShowdoctorCubit()..fetchDoctors(),
        ),
         BlocProvider<ShowAppointmentsCubit>(
          create: (context) => ShowAppointmentsCubit()..fetchAppointments(),
        ),
         BlocProvider<WaitinglistCubit>(
          create: (context) => WaitinglistCubit()..fetchWaitingList(),
        ),
         BlocProvider<UpdateAppointmentStatusCubit>(
          create: (context) => UpdateAppointmentStatusCubit(),
        ),
          BlocProvider<ShowSpecialtiesbyidCubit>(
          create: (context) => ShowSpecialtiesbyidCubit(ApiService()),
        ),

      ],
      child: DentalogApp(), 
    ),
  );
}

class DentalogApp extends StatelessWidget {
  const DentalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
      routerConfig: AppRouter.getRouter(AppRouter.kSplashView ),
      debugShowCheckedModeBanner: false,
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,

    );
  }
}
