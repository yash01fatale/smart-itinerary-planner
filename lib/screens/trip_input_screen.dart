import 'package:flutter/material.dart';

import '../services/itinerary_api.dart';
import '../models/day_plan.dart';
import '../screens/ItineraryScreen.dart';

class TripInputScreen extends StatefulWidget {
  const TripInputScreen({super.key});

  @override
  State<TripInputScreen> createState() =>
      _TripInputScreenState();
}

class _TripInputScreenState
    extends State<TripInputScreen> {
  final destinationController =
      TextEditingController();

  final daysController =
      TextEditingController();

  bool isLoading = false;

  Future<void> generateTrip() async {
    try {
      setState(() {
        isLoading = true;
      });

      final result =
          await ItineraryApi.generateItinerary(
        destination:
            destinationController.text,
        days:
            int.parse(daysController.text),
      );

      final itinerary =
          (result["itinerary"] as List)
              .map(
                (e) => DayPlan.fromJson(e),
              )
              .toList();

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ItineraryScreen(
            itinerary: itinerary,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Smart Itinerary Planner",
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller:
                  destinationController,
              decoration:
                  const InputDecoration(
                labelText:
                    "Destination",
                border:
                    OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller:
                  daysController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    "Days",
                border:
                    OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 55,
              child:
                  ElevatedButton(
                onPressed:
                    isLoading
                        ? null
                        : generateTrip,
                child: Text(
                  isLoading
                      ? "Generating..."
                      : "Generate Itinerary",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}