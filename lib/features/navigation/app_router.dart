import 'package:flutter/material.dart';
import 'package:flutter_practice10/features/auth/screens/login_screen.dart';
import 'package:flutter_practice10/features/auth/screens/register_screen.dart';
import 'package:flutter_practice10/features/car_expenses/screens/add_expense_screen.dart';
import 'package:flutter_practice10/features/car_expenses/screens/car_expenses_screen.dart';
import 'package:flutter_practice10/features/profile/screens/edit_profile_screen.dart';
import 'package:flutter_practice10/features/profile/screens/profile_screen.dart';
import 'package:flutter_practice10/features/service_history/screens/add_service_record_screen.dart';
import 'package:flutter_practice10/features/service_history/screens/service_history_screen.dart';
import 'package:flutter_practice10/features/tips/screens/tip_detail_screen.dart';
import 'package:flutter_practice10/features/tips/screens/tips_screen.dart';
import 'package:flutter_practice10/features/vehicle_info/screens/vehicle_info_screen.dart';
import 'package:flutter_practice10/features/vehicles/screens/add_vehicle_screen.dart';
import 'package:flutter_practice10/features/vehicles/screens/edit_vehicle_screen.dart';
import 'package:flutter_practice10/features/vehicles/screens/vehicle_details_screen.dart';
import 'package:flutter_practice10/features/vehicles/screens/vehicles_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/auth/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/auth/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/auth/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: 'edit',
          builder: (context, state) => const EditProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/vehicles',
      builder: (context, state) => const VehiclesScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: 'add',
          builder: (context, state) => const AddVehicleScreen(),
        ),
        GoRoute(
          path: 'edit/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return EditVehicleScreen(vehicleId: id);
          },
        ),
        GoRoute(
          path: 'details/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return VehicleDetailsScreen(vehicleId: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/expenses',
      builder: (BuildContext context, GoRouterState state) {
        return const CarExpensesScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'add',
          builder: (BuildContext context, GoRouterState state) {
            return const AddExpenseScreen();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/tips',
      builder: (context, state) => const TipsScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return TipDetailScreen(tipId: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/info',
      builder: (context, state) => const VehicleInfoScreen(),
    ),
    GoRoute(
        path: '/history',
        builder: (BuildContext context, GoRouterState state) {
          return const ServiceHistoryScreen();
        },
        routes: [
          GoRoute(
            path: 'add',
            builder: (BuildContext context, GoRouterState state) {
              return const AddServiceRecordScreen();
            },
          ),
        ]),
  ],
);

