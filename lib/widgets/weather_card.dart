import 'package:flutter/material.dart';
import '../models/weather_data.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFAFECFF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Image.network(
            "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
            width: 60,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${weather.temp}°C",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(weather.description),
                Text(weather.city),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
