import 'package:smart_itinerary_planner/models/itinerary_model.dart';
// import 'place.dart';

class DayPlan {
  final int day;
  final List<Place> places;

  DayPlan({
    required this.day,
    required this.places,
  });

  factory DayPlan.fromJson(Map<String, dynamic> json) {
    return DayPlan(
      day: json["day"] ?? 0,
      places: (json["places"] as List)
          .map((e) => Place.fromJson(e))
          .toList(),
    );
  }
}