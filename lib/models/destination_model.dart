class DestinationModel {
  final String name;
  final String description;
  final String image;
  final String link;
  final String flightPrice;
  final double? extractedFlightPrice;
  final String hotelPrice;
  final double? extractedHotelPrice;

  DestinationModel({
    required this.name,
    required this.description,
    required this.image,
    required this.link,
    required this.flightPrice,
    required this.extractedFlightPrice,
    required this.hotelPrice,
    required this.extractedHotelPrice,
  });

  factory DestinationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DestinationModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      link: json['link'] ?? '',
      flightPrice: json['flight_price'] ?? '',
      extractedFlightPrice:
          (json['extracted_flight_price'] as num?)
              ?.toDouble(),
      hotelPrice: json['hotel_price'] ?? '',
      extractedHotelPrice:
          (json['extracted_hotel_price'] as num?)
              ?.toDouble(),
    );
  }
}