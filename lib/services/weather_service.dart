import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_data.dart';

class WeatherService {
  static const String apiKey = '17fabb32d44e0b675df4b4f5abff304a';

  Future<WeatherModel> getWeather(String city) async {
    final response = await http.get(
      Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return WeatherModel(
        city: data['name'],
        temp: data['main']['temp'].toDouble(),
        description: data['weather'][0]['description'],
        icon: data['weather'][0]['icon'],
      );
    } else {
      throw Exception('Failed to load weather');
    }
  }
}