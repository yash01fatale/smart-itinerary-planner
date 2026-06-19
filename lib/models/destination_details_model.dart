class DestinationDetailsModel {
  final String bestTime;
  final double rating;
  final String budget;
  final List attractions;
  final List thingsToDo;

  DestinationDetailsModel({
    required this.bestTime,
    required this.rating,
    required this.budget,
    required this.attractions,
    required this.thingsToDo,
  });

  factory DestinationDetailsModel.fromJson(Map<String, dynamic> json) {
    return DestinationDetailsModel(
      bestTime: json['best_time'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      budget: json['budget'] ?? '',
      attractions: json['attractions'] ?? [],
      thingsToDo: json['things_to_do'] ?? [],
    );
  }
}
