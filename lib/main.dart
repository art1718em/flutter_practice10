import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_practice10/features/auth/logic/auth_cubit.dart';
import 'package:flutter_practice10/features/car_expenses/logic/car_expenses_cubit.dart';
import 'package:flutter_practice10/features/navigation/app_router.dart';
import 'package:flutter_practice10/features/profile/logic/profile_cubit.dart';
import 'package:flutter_practice10/features/service_history/logic/service_history_cubit.dart';
import 'package:flutter_practice10/features/tips/logic/tips_cubit.dart';
import 'package:flutter_practice10/features/vehicles/logic/vehicles_cubit.dart';
import 'package:flutter_practice10/shared/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => VehiclesCubit()),
        BlocProvider(create: (context) => CarExpensesCubit()),
        BlocProvider(create: (context) => ServiceHistoryCubit()),
        BlocProvider(create: (context) => TipsCubit()),
      ],
      child: MaterialApp.router(
        title: 'Автомобильный помощник',
        theme: AppTheme.lightTheme,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
