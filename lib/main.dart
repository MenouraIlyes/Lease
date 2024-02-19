import 'package:flutter/material.dart';
import 'package:lease/navigation/app_router.dart';
import 'package:lease/shared/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: appRed),
        useMaterial3: true,
      ),
      routerConfig: AppRouter().router,
    );
  }
}
