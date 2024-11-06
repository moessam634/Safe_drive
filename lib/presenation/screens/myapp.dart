import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safedrive/data/cubit/emergency_item_cubit/emergency_item_cubit.dart';
import 'package:safedrive/presenation/screens/splash_screen.dart';
import 'package:safedrive/presenation/screens/splash_screen2.dart';
import '../../app/app_colors.dart';
import '../../data/cubit/maps_cubit/maps_cubit.dart';
import '../../domain/repository/maps_repo.dart';
import '../../domain/webservices/places_webservices.dart';
import 'login.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        splitScreenMode: true,
        builder: (_, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => EmergencyItemCubit(),
              ),
              BlocProvider(
                create: (context) => MapsCubit(
                  MapsRepository(
                    PlacesWebservices(),
                  ),
                ),
              ),
            ],
            child: MaterialApp(
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.teel),
              ),
              debugShowCheckedModeBanner: false,
              home:
              StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData == true) {
                    return const Splash2();
                  }
                  if (snapshot.hasData == false) {
                    return const Splash();
                  }
                  return const LoginScreen();
                }),
              ),
            ),
          );
        });
  }
}