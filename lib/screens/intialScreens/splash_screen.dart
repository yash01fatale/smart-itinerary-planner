import 'dart:async';
import 'package:flutter/material.dart';
import '../../config/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _scaleAnimation;

  late AnimationController _backgroundController;
  late Animation<double> _backgroundScale;

  @override
  void initState() {
    super.initState();

    /// Logo Animation
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeOutBack,
      ),
    );

    _logoController.forward();

    /// Background Zoom Animation
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    _backgroundScale = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(
      CurvedAnimation(
        parent: _backgroundController,
        curve: Curves.easeInOut,
      ),
    );

    _backgroundController.repeat(reverse: true);

    /// Navigate
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.onboarding,
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  Widget buildFloatingIcon(
    IconData icon,
    double top,
    double left,
    double size,
  ) {
    return Positioned(
      top: top,
      left: left,
      child: Icon(
        icon,
        size: size,
        color: Colors.white.withOpacity(0.18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Animated Background
          AnimatedBuilder(
            animation: _backgroundScale,
            builder: (context, child) {
              return Transform.scale(
                scale: _backgroundScale.value,
                child: child,
              );
            },
            child: SizedBox.expand(
              child: Image.network(
                "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1500&q=80",
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Dark Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xff0F172A).withOpacity(.85),
                  Colors.transparent,
                  Colors.black.withOpacity(.75),
                ],
              ),
            ),
          ),

          /// Floating Travel Icons
          buildFloatingIcon(
            Icons.flight,
            140,
            30,
            38,
          ),

          buildFloatingIcon(
            Icons.location_on,
            180,
            MediaQuery.of(context).size.width - 70,
            32,
          ),

          buildFloatingIcon(
            Icons.public,
            520,
            50,
            45,
          ),

          buildFloatingIcon(
            Icons.explore,
            620,
            MediaQuery.of(context).size.width - 80,
            40,
          ),

          SafeArea(
            child: Column(
              children: [
                const Spacer(),

                /// Logo
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withOpacity(.25),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.25),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.flight_takeoff_rounded,
                      size: 70,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// App Name
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [
                        Color(0xff00D4FF),
                        Color(0xff7C3AED),
                      ],
                    ).createShader(bounds);
                  },
                  child: const Text(
                    "TravelWise AI",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Explore The World Smarter",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 25),

                /// Glass Info Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.12),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: Colors.white.withOpacity(.15),
                    ),
                  ),
                  child: const Text(
                    "AI-powered itineraries, destination insights, smart trip planning and personalized travel experiences crafted just for you.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.6,
                      fontSize: 15,
                    ),
                  ),
                ),

                const Spacer(),

                /// Loading Text
                const Text(
                  "Preparing your next adventure...",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 18),

                /// Progress Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const LinearProgressIndicator(
                      minHeight: 8,
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation(
                        Color(0xff00D4FF),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                /// Footer
                Column(
                  children: const [
                    Text(
                      "Powered by AI Travel Assistant",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Discover • Plan • Explore",
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}