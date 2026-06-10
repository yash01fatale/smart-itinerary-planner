class RecommendationModel {
  final String title;
  final String description;
  final String link;
  final String flightPrice;
  final double? extractedFlightPrice;
  final String hotelPrice;
  final double? extractedHotelPrice;
  final String thumbnail;
  final String city;
  final String country;

  RecommendationModel({
    required this.title,
    required this.description,
    required this.link,
    required this.flightPrice,
    required this.extractedFlightPrice,
    required this.hotelPrice,
    required this.extractedHotelPrice,
    required this.thumbnail,
    required this.city,
    required this.country,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    final rawTitle = json['title'] ?? '';
    final titleParts = rawTitle.toString().split(',');
    final city =
        titleParts.isNotEmpty ? titleParts[0].trim() : rawTitle.toString();
    final country =
        titleParts.length > 1 ? titleParts.sublist(1).join(',').trim() : '';

    return RecommendationModel(
      title: rawTitle.toString(),
      description: json['description'] ?? '',
      link: json['link'] ?? '',
      flightPrice: json['flight_price'] ?? json['flightPrice'] ?? '',
      extractedFlightPrice:
          (json['extracted_flight_price'] as num?)?.toDouble(),
      hotelPrice: json['hotel_price'] ?? '',
      extractedHotelPrice: (json['extracted_hotel_price'] as num?)?.toDouble(),
      thumbnail: json['thumbnail'] ?? '',
      city: city,
      country: country,
    );
  }
}
