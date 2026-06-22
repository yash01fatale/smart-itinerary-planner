import 'package:flutter/material.dart';
import 'package:smart_itinerary_planner/widgets/app_bottom_nav_bar.dart';

import '../services/itinerary_api.dart';
import '../models/day_plan.dart';
import '../screens/ItineraryScreen.dart' hide DayPlan;

class TripInputScreen extends StatefulWidget {
  const TripInputScreen({super.key});

  @override
  State<TripInputScreen> createState() => _TripInputScreenState();
}

class _TripInputScreenState extends State<TripInputScreen> {
  final destinationController = TextEditingController();
  final daysController = TextEditingController();

  bool isLoading = false;

  final List<String> _trendingDestinations = [
    'Paris, France',
    'Kyoto, Japan',
    'Bali, Indonesia',
    'Rome, Italy',
    'New York, USA',
  ];

  Future<void> generateTrip() async {
    if (destinationController.text.trim().isEmpty ||
        daysController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all travel details"),
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final result = await ItineraryApi.generateItinerary(
        destination: destinationController.text.trim(),
        days: int.parse(daysController.text.trim()),
      );

      final itinerary = (result["itinerary"] as List)
          .map((e) => DayPlan.fromJson(e))
          .toList();

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ItineraryScreen(
            itinerary: itinerary,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color(0xFFEAF8FF),
      bottomNavigationBar: const AppBottomNavBar(selectedIndex: 0),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFBFE9FF),
              Color(0xFFEAF8FF),
              Color(0xFFFFFFFF),
            ],
          ),
        ),

        child: Stack(
          children: [
            Positioned(
              top: -80,
              right: -60,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(.25),
                ),
              ),
            ),

            Positioned(
              bottom: -40,
              left: -40,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF81D4FA).withOpacity(.15),
                ),
              ),
            ),

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 550,
                    ),
                    child: _buildContent(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                Color(0xFF4FC3F7),
                Color(0xFF0288D1),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(.25),
                blurRadius: 25,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: const Icon(
            Icons.flight_takeoff_rounded,
            size: 65,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 28),

        const Text(
          "Plan Your Dream Trip",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          "Generate an AI-powered travel itinerary in seconds.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF64748B),
            fontSize: 15,
          ),
        ),

        const SizedBox(height: 30),

        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.90),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(.08),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Destination",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF334155),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: destinationController,
                decoration: InputDecoration(
                  hintText: "Where would you like to go?",
                  prefixIcon: const Icon(
                    Icons.location_on_rounded,
                    color: Color(0xFF0288D1),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _trendingDestinations.map((city) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      setState(() {
                        destinationController.text = city;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFFD6EEFF),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.travel_explore,
                            size: 16,
                            color: Color(0xFF0288D1),
                          ),
                          const SizedBox(width: 6),
                          Text(city),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              const Text(
                "Trip Duration",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF334155),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: daysController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "5 Days",
                  prefixIcon: const Icon(
                    Icons.calendar_month_rounded,
                    color: Color(0xFF0288D1),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF4FC3F7),
                        Color(0xFF0288D1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(.30),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: isLoading ? null : generateTrip,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Generate My Trip",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(.05),
                blurRadius: 20,
              ),
            ],
          ),
          child: const Row(
            children: [
              Icon(
                Icons.smart_toy_rounded,
                color: Color(0xFF0288D1),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "AI creates a personalized day-by-day itinerary with attractions, food recommendations, and activities.",
                  style: TextStyle(
                    color: Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    destinationController.dispose();
    daysController.dispose();
    super.dispose();
  }
}

