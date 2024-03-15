import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lease/screens/booking_details_screen.dart';
import 'package:lease/screens/home_screen.dart';
import 'package:lease/screens/first_screen.dart';
import 'package:lease/screens/login_screen.dart';
import 'package:lease/screens/register_screen.dart';
import 'package:lease/screens/vehicles_list_screen.dart';
import 'package:lease/shared/colors.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: 'home',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const VehicleListScreen();
        },
      ),
      GoRoute(
          name: 'booking-details',
          path: '/booking-details',
          pageBuilder: (context, state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              opaque: false,
              barrierColor: appBlack.withOpacity(0.5),
              transitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
              child: const BookingDetailsScreen(),
            );
          })
    ],
  );
}
