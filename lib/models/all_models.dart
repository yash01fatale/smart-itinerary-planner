// lib/models/destination_model.dart
class DestinationModel {
  final String id;
  final String name;
  final String state;
  final String country;
  final String category;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final String bestTimeToVisit;
  final bool isFeatured;
  bool isFavorite;

  DestinationModel({
    required this.id, required this.name, required this.state,
    this.country = 'India', required this.category, required this.description,
    required this.imageUrl, required this.latitude, required this.longitude,
    this.rating = 4.0, this.reviewCount = 0, this.tags = const [],
    required this.bestTimeToVisit, this.isFeatured = false, this.isFavorite = false,
  });

  factory DestinationModel.fromMap(Map<String, dynamic> map) => DestinationModel(
    id: map['id'] ?? '', name: map['name'] ?? '', state: map['state'] ?? '',
    country: map['country'] ?? 'India', category: map['category'] ?? '',
    description: map['description'] ?? '', imageUrl: map['imageUrl'] ?? '',
    latitude: (map['latitude'] ?? 0.0).toDouble(), longitude: (map['longitude'] ?? 0.0).toDouble(),
    rating: (map['rating'] ?? 4.0).toDouble(), reviewCount: map['reviewCount'] ?? 0,
    tags: List<String>.from(map['tags'] ?? []), bestTimeToVisit: map['bestTimeToVisit'] ?? '',
    isFeatured: map['isFeatured'] ?? false, isFavorite: map['isFavorite'] ?? false,
  );

  Map<String, dynamic> toMap() => {
    'id': id, 'name': name, 'state': state, 'country': country, 'category': category,
    'description': description, 'imageUrl': imageUrl, 'latitude': latitude, 'longitude': longitude,
    'rating': rating, 'reviewCount': reviewCount, 'tags': tags,
    'bestTimeToVisit': bestTimeToVisit, 'isFeatured': isFeatured, 'isFavorite': isFavorite,
  };
}

// lib/models/spot_model.dart
class SpotModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final double rating;
  final String suggestedDuration;
  final double distanceFromPrev;
  final String timeSlot;
  final double entryFee;
  final List<String> tags;

  SpotModel({
    required this.id, required this.name, required this.description,
    required this.category, this.imageUrl = '', required this.latitude,
    required this.longitude, this.rating = 4.0, required this.suggestedDuration,
    this.distanceFromPrev = 0.0, required this.timeSlot, this.entryFee = 0.0,
    this.tags = const [],
  });

  factory SpotModel.fromMap(Map<String, dynamic> map) => SpotModel(
    id: map['id'] ?? '', name: map['name'] ?? '', description: map['description'] ?? '',
    category: map['category'] ?? '', imageUrl: map['imageUrl'] ?? '',
    latitude: (map['latitude'] ?? 0.0).toDouble(), longitude: (map['longitude'] ?? 0.0).toDouble(),
    rating: (map['rating'] ?? 4.0).toDouble(), suggestedDuration: map['suggestedDuration'] ?? '1 hr',
    distanceFromPrev: (map['distanceFromPrev'] ?? 0.0).toDouble(),
    timeSlot: map['timeSlot'] ?? '10:00 AM', entryFee: (map['entryFee'] ?? 0.0).toDouble(),
    tags: List<String>.from(map['tags'] ?? []),
  );

  Map<String, dynamic> toMap() => {
    'id': id, 'name': name, 'description': description, 'category': category,
    'imageUrl': imageUrl, 'latitude': latitude, 'longitude': longitude,
    'rating': rating, 'suggestedDuration': suggestedDuration,
    'distanceFromPrev': distanceFromPrev, 'timeSlot': timeSlot,
    'entryFee': entryFee, 'tags': tags,
  };
}

// lib/models/day_plan_model.dart
class MealSuggestion {
  final String type; // breakfast, lunch, dinner
  final String restaurantName;
  final String cuisine;
  final double estimatedCost;

  MealSuggestion({required this.type, required this.restaurantName, required this.cuisine, required this.estimatedCost});

  factory MealSuggestion.fromMap(Map<String, dynamic> map) => MealSuggestion(
    type: map['type'] ?? 'lunch', restaurantName: map['restaurantName'] ?? '',
    cuisine: map['cuisine'] ?? '', estimatedCost: (map['estimatedCost'] ?? 0.0).toDouble(),
  );

  Map<String, dynamic> toMap() => {'type': type, 'restaurantName': restaurantName, 'cuisine': cuisine, 'estimatedCost': estimatedCost};
}

class DayPlanModel {
  final int dayNumber;
  final String theme;
  final List<SpotModel> spots;
  final List<MealSuggestion> meals;
  final double totalDistance;
  final double estimatedCost;
  final String note;

  DayPlanModel({
    required this.dayNumber, required this.theme, required this.spots,
    this.meals = const [], this.totalDistance = 0.0, this.estimatedCost = 0.0, this.note = '',
  });

  factory DayPlanModel.fromMap(Map<String, dynamic> map) => DayPlanModel(
    dayNumber: map['dayNumber'] ?? 1, theme: map['theme'] ?? '',
    spots: (map['spots'] as List<dynamic>? ?? []).map((s) => SpotModel.fromMap(s)).toList(),
    meals: (map['meals'] as List<dynamic>? ?? []).map((m) => MealSuggestion.fromMap(m)).toList(),
    totalDistance: (map['totalDistance'] ?? 0.0).toDouble(),
    estimatedCost: (map['estimatedCost'] ?? 0.0).toDouble(), note: map['note'] ?? '',
  );

  Map<String, dynamic> toMap() => {
    'dayNumber': dayNumber, 'theme': theme,
    'spots': spots.map((s) => s.toMap()).toList(),
    'meals': meals.map((m) => m.toMap()).toList(),
    'totalDistance': totalDistance, 'estimatedCost': estimatedCost, 'note': note,
  };
}

// lib/models/trip_model.dart
class TripModel {
  final String id;
  final String userId;
  final String destinationId;
  final String destinationName;
  final int days;
  final int adults;
  final int children;
  final String budgetTier;
  final List<String> interests;
  final DateTime? travelDate;
  final String status; // planned, ongoing, completed
  final DateTime createdAt;

  TripModel({
    required this.id, required this.userId, required this.destinationId,
    required this.destinationName, required this.days, required this.adults,
    this.children = 0, required this.budgetTier, this.interests = const [],
    this.travelDate, this.status = 'planned', required this.createdAt,
  });

  int get totalPeople => adults + children;

  factory TripModel.fromMap(Map<String, dynamic> map) => TripModel(
    id: map['id'] ?? '', userId: map['userId'] ?? '', destinationId: map['destinationId'] ?? '',
    destinationName: map['destinationName'] ?? '', days: map['days'] ?? 1,
    adults: map['adults'] ?? 1, children: map['children'] ?? 0,
    budgetTier: map['budgetTier'] ?? '₹₹ Mid-range',
    interests: List<String>.from(map['interests'] ?? []),
    travelDate: map['travelDate'] != null ? DateTime.parse(map['travelDate']) : null,
    status: map['status'] ?? 'planned',
    createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
  );

  Map<String, dynamic> toMap() => {
    'id': id, 'userId': userId, 'destinationId': destinationId,
    'destinationName': destinationName, 'days': days, 'adults': adults,
    'children': children, 'budgetTier': budgetTier, 'interests': interests,
    'travelDate': travelDate?.toIso8601String(), 'status': status,
    'createdAt': createdAt.toIso8601String(),
  };
}

// lib/models/itinerary_model.dart
class BudgetBreakdown {
  final double transportation;
  final double accommodation;
  final double food;
  final double entryFees;
  final double shopping;
  final double miscellaneous;

  BudgetBreakdown({
    this.transportation = 0, this.accommodation = 0, this.food = 0,
    this.entryFees = 0, this.shopping = 0, this.miscellaneous = 0,
  });

  double get total => transportation + accommodation + food + entryFees + shopping + miscellaneous;

  factory BudgetBreakdown.fromMap(Map<String, dynamic> map) => BudgetBreakdown(
    transportation: (map['transportation'] ?? 0).toDouble(),
    accommodation: (map['accommodation'] ?? 0).toDouble(),
    food: (map['food'] ?? 0).toDouble(), entryFees: (map['entryFees'] ?? 0).toDouble(),
    shopping: (map['shopping'] ?? 0).toDouble(), miscellaneous: (map['miscellaneous'] ?? 0).toDouble(),
  );

  Map<String, dynamic> toMap() => {
    'transportation': transportation, 'accommodation': accommodation, 'food': food,
    'entryFees': entryFees, 'shopping': shopping, 'miscellaneous': miscellaneous,
  };
}

class ItineraryModel {
  final String id;
  final TripModel trip;
  final List<DayPlanModel> dayPlans;
  final BudgetBreakdown budget;
  final String weatherSummary;
  final String generalTips;
  final List<String> packingList;
  final bool isSaved;
  final DateTime generatedAt;

  ItineraryModel({
    required this.id, required this.trip, required this.dayPlans,
    required this.budget, this.weatherSummary = '', this.generalTips = '',
    this.packingList = const [], this.isSaved = false, required this.generatedAt,
  });

  double get totalCost => budget.total;
  double get costPerPerson => trip.totalPeople > 0 ? totalCost / trip.totalPeople : totalCost;

  factory ItineraryModel.fromMap(Map<String, dynamic> map) => ItineraryModel(
    id: map['id'] ?? '',
    trip: TripModel.fromMap(map['trip'] ?? {}),
    dayPlans: (map['dayPlans'] as List<dynamic>? ?? []).map((d) => DayPlanModel.fromMap(d)).toList(),
    budget: BudgetBreakdown.fromMap(map['budget'] ?? {}),
    weatherSummary: map['weatherSummary'] ?? '', generalTips: map['generalTips'] ?? '',
    packingList: List<String>.from(map['packingList'] ?? []), isSaved: map['isSaved'] ?? false,
    generatedAt: DateTime.parse(map['generatedAt'] ?? DateTime.now().toIso8601String()),
  );

  Map<String, dynamic> toMap() => {
    'id': id, 'trip': trip.toMap(),
    'dayPlans': dayPlans.map((d) => d.toMap()).toList(),
    'budget': budget.toMap(), 'weatherSummary': weatherSummary,
    'generalTips': generalTips, 'packingList': packingList,
    'isSaved': isSaved, 'generatedAt': generatedAt.toIso8601String(),
  };
}

// lib/models/weather_model.dart
class WeatherModel {
  final String description;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String icon;
  final DateTime date;

  WeatherModel({
    required this.description, required this.temperature, required this.feelsLike,
    required this.humidity, required this.windSpeed, required this.icon, required this.date,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> map) => WeatherModel(
    description: map['description'] ?? '', temperature: (map['temperature'] ?? 0).toDouble(),
    feelsLike: (map['feelsLike'] ?? 0).toDouble(), humidity: map['humidity'] ?? 0,
    windSpeed: (map['windSpeed'] ?? 0).toDouble(), icon: map['icon'] ?? '',
    date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
  );
}