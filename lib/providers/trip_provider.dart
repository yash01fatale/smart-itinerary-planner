import 'package:flutter/material.dart';

class TripProvider extends ChangeNotifier {
  Map<String, dynamic>? currentTrip;

  void setTrip(
    Map<String, dynamic> trip,
  ) {
    currentTrip = trip;
    notifyListeners();
  }

  void clearTrip() {
    currentTrip = null;
    notifyListeners();
  }
}