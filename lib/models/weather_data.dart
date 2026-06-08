class WeatherModel {
  final double temp;
  final String description;
  final String icon;
  final String city;

  WeatherModel({
    required this.temp,
    required this.description,
    required this.icon,
    required this.city,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      city: json['name'],
    );
  }
}