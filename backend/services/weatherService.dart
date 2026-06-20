import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_itinerary_planner/models/weather_data.dart';

class WeatherService {
  static const String apiKey = "YOUR_OPENWEATHER_API_KEY";

  Future<WeatherModel> getWeather(
    String city,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric",
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return WeatherModel(
          temp: (data['main']['temp'] ?? 0).toDouble(),
          humidity: data['main']['humidity'] ?? 0,
          description: data['weather'][0]['description'] ?? '',
          icon: data['weather'][0]['icon'] ?? '01d',
          city: data['name'] ?? city,
        );
      }

      throw Exception(
        "Weather API Error: ${response.statusCode}",
      );
    } catch (e) {
      throw Exception(
        "Failed to load weather: $e",
      );
    }
  }
}
