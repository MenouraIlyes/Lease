import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lease/screens/booking_details_screen.dart';
import 'package:lease/screens/home_screen.dart';
import 'package:lease/screens/login_register_screen.dart';
import 'package:lease/screens/vehicles_list_screen.dart';
import 'package:lease/screens/welcom_screen.dart';
import 'package:lease/shared/colors.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: '/welcome', // Set the initial location
    routes: <GoRoute>[
      GoRoute(
        name: 'welcome',
        path: '/welcome',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        name: 'login-or-register',
        path: '/login-or-register',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginOrRegisterScreen();
        },
      ),
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
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
        },
      ),
      GoRoute(
        name: 'home-logged-in',
        path: '/home-logged-in',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen(); // Your HomeScreen widget
        },
      ),
      GoRoute(
        name: 'home-registered',
        path: '/home-registered',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen(); // Your HomeScreen widget
        },
      ),
    ],
  );
}
