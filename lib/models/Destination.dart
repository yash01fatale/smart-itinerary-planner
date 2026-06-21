class Destination {
  final String destinationId;
  final String name;
  final String country;

  final double latitude;
  final double longitude;

  final String thumbnail;

  final String airportCode;
  final String airportLocation;
  final String airportName;

  final String startDate;
  final String endDate;

  final double flightPrice;
  final double hotelPrice;

  final int flightDuration;
  final int numberOfStops;

  final String airline;
  final String airlineCode;

  final String link;
  final String serpApiLink;

  Destination({
    required this.destinationId,
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.thumbnail,
    required this.airportCode,
    required this.airportLocation,
    required this.airportName,
    required this.startDate,
    required this.endDate,
    required this.flightPrice,
    required this.hotelPrice,
    required this.flightDuration,
    required this.numberOfStops,
    required this.airline,
    required this.airlineCode,
    required this.link,
    required this.serpApiLink,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      destinationId: json['destination_id'] ?? '',
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      latitude: ((json['gps_coordinates'] ?? {})['latitude'] ?? 0).toDouble(),
      longitude: ((json['gps_coordinates'] ?? {})['longitude'] ?? 0).toDouble(),
      thumbnail: json['thumbnail'] ?? '',
      airportCode:
          ((json['destination_airport'] ?? {})['code'] ?? '').toString(),
      airportLocation:
          ((json['destination_airport'] ?? {})['location'] ?? '').toString(),
      airportName:
          ((json['destination_airport'] ?? {})['name'] ?? '').toString(),
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      flightPrice: (json['flight_price'] ?? 0).toDouble(),
      hotelPrice: (json['hotel_price'] ?? 0).toDouble(),
      flightDuration: json['flight_duration'] ?? 0,
      numberOfStops: json['number_of_stops'] ?? 0,
      airline: json['airline'] ?? '',
      airlineCode: json['airline_code'] ?? '',
      link: json['link'] ?? '',
      serpApiLink: json['serpapi_link'] ?? '',
    );
  }
}
