import 'dart:async';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Map<String, dynamic>? tripData;

  bool _initialized = false;

  final List<String> loadingSteps = [
    "Analyzing destination...",
    "Finding nearby attractions...",
    "Checking weather conditions...",
    "Optimizing travel route...",
    "Generating itinerary...",
  ];

  int currentStep = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      _initialized = true;

      tripData =
          ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

      startLoading();
    }
  }

  Future<void> startLoading() async {
    for (int i = 0; i < loadingSteps.length; i++) {
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() {
          currentStep = i;
        });
      }
    }

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    Navigator.pushReplacementNamed(
      context,
      '/itinerary',
      arguments: tripData,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotationTransition(
                turns: _controller,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xffFBBF24),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: const Icon(
                    Icons.travel_explore,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                "Generating Your Smart Trip",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                loadingSteps[currentStep],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              LinearProgressIndicator(
                value:
                    (currentStep + 1) / loadingSteps.length,
                minHeight: 10,
                borderRadius:
                    BorderRadius.circular(20),
              ),

              const SizedBox(height: 20),

              Text(
                "${((currentStep + 1) / loadingSteps.length * 100).toInt()}%",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: const [
                      ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),
                        title: Text(
                          "Finding attractions",
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.route,
                          color: Colors.green,
                        ),
                        title: Text(
                          "Optimizing route",
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.cloud,
                          color: Colors.orange,
                        ),
                        title: Text(
                          "Checking weather",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}