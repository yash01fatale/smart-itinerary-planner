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

  String destination = "Mumbai";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is String) {
      destination = args;
    }

    weatherFuture = weatherService.getWeather(destination);
  }

  Future<void> refreshWeather() async {
    setState(() {
      weatherFuture = weatherService.getWeather(destination);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        title: Text("Weather - $destination"),
        backgroundColor: const Color(0xff006591),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: refreshWeather,
          ),
        ],
      ),

      body: FutureBuilder<WeatherModel>(
        future: weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error : ${snapshot.error}",
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                "No Weather Data Found",
              ),
            );
          }

          final weather = snapshot.data!;

          return RefreshIndicator(
            onRefresh: refreshWeather,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [

                /// Main Weather Card
                WeatherCard(weather: weather),

                const SizedBox(height: 20),

                /// Details Card
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                          children: [

                            _buildInfoTile(
                              Icons.thermostat,
                              "${weather.temp}°C",
                              "Temp",
                            ),

                            _buildInfoTile(
                              Icons.water_drop,
                              "${weather.humidity}%",
                              "Humidity",
                            ),

                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Travel Precautions",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                _precautionTile(
                  "Carry drinking water",
                  Icons.water,
                ),

                _precautionTile(
                  "Keep power bank charged",
                  Icons.battery_charging_full,
                ),

                _precautionTile(
                  "Keep emergency contacts",
                  Icons.emergency,
                ),

                _precautionTile(
                  "Check weather before travel",
                  Icons.cloud,
                ),

                const SizedBox(height: 20),

                const Text(
                  "Packing Suggestions",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: const [

                    Chip(
                      avatar: Icon(Icons.sunny),
                      label: Text("Sunglasses"),
                    ),

                    Chip(
                      avatar: Icon(Icons.water),
                      label: Text("Water Bottle"),
                    ),

                    Chip(
                      avatar: Icon(Icons.phone_android),
                      label: Text("Power Bank"),
                    ),

                    Chip(
                      avatar: Icon(Icons.checkroom),
                      label: Text("Light Jacket"),
                    ),

                    Chip(
                      avatar: Icon(Icons.hiking),
                      label: Text("Walking Shoes"),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoTile(
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 35,
          color: Colors.blue,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label),
      ],
    );
  }

  Widget _precautionTile(
    String title,
    IconData icon,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
        ),
        title: Text(title),
      ),
    );
  }
}