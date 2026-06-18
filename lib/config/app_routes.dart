import 'package:flutter/material.dart';
import 'package:smart_itinerary_planner/screens/exploreScreen.dart';

import '../screens/intialScreens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/intialScreens/login_screen.dart';
import '../screens/intialScreens/signup_screen.dart';
import '../screens/intialScreens/forgot_password_screen.dart';
import '../screens/home_screen.dart';
import '../screens/trip_input_screen.dart';
import '../screens/saved_trips_screen.dart';
import '../screens/messageScreens/Message_screen.dart';
import '../screens/intialScreens/profile/profile_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const home = '/home';
  static const destination = "/destination";
  static const tripInput = "/tripInput";
  static const destinationDetail = "/destinationDetail";
  static const trips = "/trips";
  static const savedTrips = "/savedTrips";
  static const profileScreen = "/profile";
  static const chatbot = "/chatbot";
  static const messagesScreen = "/chatscreen";
  static const exploreScreen = "/explore";

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashScreen(),
        onboarding: (_) => const OnboardingScreen(),
        login: (_) => LoginScreen(),
        signup: (_) => SignupScreen(),
        forgotPassword: (_) => const ForgotPasswordScreen(),
        home: (_) => HomeScreen(),
        tripInput: (_) => const TripInputScreen(),
        savedTrips: (_) => const SavedTripsScreen(),
        messagesScreen: (_) => const MessagesScreen(),
        profileScreen: (_) => const ProfileScreen(),
        exploreScreen: (_) => const ExploreScreen(),
      };
}
