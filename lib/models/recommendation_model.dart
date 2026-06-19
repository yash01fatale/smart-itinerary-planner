class RecommendationModel {
  final String title;
  final String description;
  final String link;
  final String flightPrice;
  final double? extractedFlightPrice;
  final String hotelPrice;
  final double? extractedHotelPrice;
  final String thumbnail;

  RecommendationModel({
    required this.title,
    required this.description,
    required this.link,
    required this.flightPrice,
    required this.extractedFlightPrice,
    required this.hotelPrice,
    required this.extractedHotelPrice,
    required this.thumbnail,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      title: json['title'] ?? json['name'] ?? '',
      description: json['description'] ?? '',
      link: json['link'] ?? '',
      flightPrice: json['flight_price'] ?? '',
      extractedFlightPrice: (json['extracted_flight_price'] as num?)?.toDouble(),
      hotelPrice: json['hotel_price'] ?? '',
      extractedHotelPrice: (json['extracted_hotel_price'] as num?)?.toDouble(),
      thumbnail: json['thumbnail'] ?? json['image'] ?? '',
    );
  }
}