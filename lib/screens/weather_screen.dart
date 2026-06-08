import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_data.dart';
import '../widgets/weather_card.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService weatherService = WeatherService();
  late Future<WeatherModel> weatherFuture;

  @override
  void initState() {
    super.initState();
    weatherFuture = weatherService.getWeather('Mumbai');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        backgroundColor: const Color(0xff006591),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<WeatherModel>(
          future: weatherFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Unable to load weather: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('No weather data found.'));
            }
            return WeatherCard(weather: snapshot.data!);
          },
        ),
      ),
    );
  }
}
