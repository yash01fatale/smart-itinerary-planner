class WeatherModel {
  final double temp;
  final int humidity;
  final String description;
  final String icon;
  final String city;

  WeatherModel({
    required this.temp,
    required this.humidity,
    required this.description,
    required this.icon,
    required this.city,
  });

  factory WeatherModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return WeatherModel(
      temp: (json['main']['temp'] ?? 0).toDouble(),
      humidity: json['main']['humidity'] ?? 0,
      description:
          json['weather'][0]['description'] ?? '',
      icon:
          json['weather'][0]['icon'] ?? '01d',
      city:
          json['name'] ?? 'Unknown',
    );
  }
}