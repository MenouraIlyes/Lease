import 'package:flutter/material.dart';
import 'package:lease/navigation/app_router.dart';
import 'package:lease/providers/reservation_provider.dart';
import 'package:lease/providers/user_profile_provider.dart';
import 'package:lease/providers/vehicle_provider.dart';
import 'package:lease/shared/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      // Use MultiProvider to wrap multiple providers
      providers: [
        ChangeNotifierProvider(create: (_) => VehicleProvider()),
        ChangeNotifierProvider(create: (_) => ReservationProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: appRed),
        useMaterial3: true,
      ),
      routerConfig: AppRouter().router,
    );
  }
}
