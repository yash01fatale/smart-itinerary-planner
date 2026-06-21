import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'config/app_routes.dart';
import 'config/app_theme.dart';

import 'providers/auth_provider.dart';
import 'providers/trip_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("database connected sucessfully");
    
  } catch (e) {
    print("Database is not connected");
  }

  runApp(const SmartItineraryPlanner());
}

class SmartItineraryPlanner extends StatelessWidget {
  const SmartItineraryPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<TripProvider>(
          create: (_) => TripProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Smart Itinerary Planner',
        debugShowCheckedModeBanner: false,

        // Theme
        theme: AppTheme.lightTheme,

        // First Screen
        initialRoute: AppRoutes.splash,

        // Routes
        routes: AppRoutes.routes,
      ),
    );
  }
}
