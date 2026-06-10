import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'firebase_options.dart';
import 'config/app_routes.dart';
import 'config/app_theme.dart';

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
    print(e);
  }

  runApp(const SmartItineraryPlanner());
}

class SmartItineraryPlanner extends StatelessWidget {
  const SmartItineraryPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Itinerary Planner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      builder: (context, child) {
        return ChangeNotifierProvider(
          create: (context) => AuthProvider(),
          child: child!,
        );
      },
    );
  }
}
