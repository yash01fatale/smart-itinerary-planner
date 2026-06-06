// lib/config/app_constants.dart
import 'package:flutter/material.dart';

class AppConstants {
  // API Keys - replace with your own
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY';
  static const String weatherApiKey = 'YOUR_OPENWEATHER_API_KEY';
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';

  // App Info
  static const String appName = 'TripGenie';
  static const String appVersion = '1.0.0';

  // Collections
  static const String usersCollection = 'users';
  static const String tripsCollection = 'trips';
  static const String favoritesCollection = 'favorites';

  // Preferences keys
  static const String prefOnboarded = 'onboarded';
  static const String prefUserId = 'user_id';
  static const String prefTheme = 'theme_mode';

  // Trip limits
  static const int minDays = 1;
  static const int maxDays = 15;
  static const int minPeople = 1;
  static const int maxPeople = 20;

  // Budget tiers
  static const List<String> budgetTiers = [
    '₹ Budget',
    '₹₹ Mid-range',
    '₹₹₹ Comfort',
    '₹₹₹₹ Luxury',
  ];

  // Interest options
  static const List<Map<String, dynamic>> interests = [
    {'label': 'Adventure', 'icon': Icons.terrain},
    {'label': 'Photography', 'icon': Icons.camera_alt_outlined},
    {'label': 'Culture', 'icon': Icons.account_balance_outlined},
    {'label': 'Food', 'icon': Icons.restaurant_outlined},
    {'label': 'Nature', 'icon': Icons.forest_outlined},
    {'label': 'Leisure', 'icon': Icons.beach_access_outlined},
    {'label': 'Shopping', 'icon': Icons.shopping_bag_outlined},
    {'label': 'Spiritual', 'icon': Icons.self_improvement_outlined},
  ];

  // Categories
  static const List<Map<String, dynamic>> categories = [
    {'label': 'Hill Stations', 'icon': Icons.terrain, 'count': 42},
    {'label': 'Beaches', 'icon': Icons.beach_access_outlined, 'count': 28},
    {'label': 'Historical', 'icon': Icons.account_balance_outlined, 'count': 55},
    {'label': 'Nature', 'icon': Icons.forest_outlined, 'count': 34},
    {'label': 'Pilgrimage', 'icon': Icons.temple_hindu_outlined, 'count': 67},
    {'label': 'Adventure', 'icon': Icons.paragliding_outlined, 'count': 23},
  ];
}