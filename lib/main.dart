import 'package:dentalog/Features/auth/presentation/manager/cubit/profile_cubit/profile_cubit.dart';
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
      routerConfig: AppRouter.getRouter(AppRouter.kSplashView),
      debugShowCheckedModeBanner: false,
      // ignore: deprecated_member_use
      useInheritedMediaQuery: true,

    );
  }
}
