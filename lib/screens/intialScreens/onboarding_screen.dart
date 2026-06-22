import 'package:flutter/material.dart';
import '../../config/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
  final PageController _controller =
      PageController();

  int currentPage = 0;

  final pages = [
    {
      "image":
          "assets/images/onboarding1.png",
      "title": "Discover Hidden Gems",
      "subtitle":
          "Explore breathtaking destinations with your loved ones."
    },
    {
      "image":
          "assets/images/onboarding2.png",
      "title": "Walk Through History",
      "subtitle":
          "Visit iconic landmarks and historical wonders around the world."
    },
    {
      "image":
          "assets/images/onboarding3.png",
      "title": "Create Unforgettable Memories",
      "subtitle":
          "Plan perfect trips with AI-powered travel experiences."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    pages[index]["image"]!,
                    fit: BoxFit.cover,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin:
                            Alignment.topCenter,
                        end:
                            Alignment.bottomCenter,
                        colors: [
                          Colors.black
                              .withOpacity(0.2),
                          Colors.black
                              .withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    left: 30,
                    right: 30,
                    bottom: 180,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          pages[index]["title"]!,
                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                            fontSize: 34,
                            fontWeight:
                                FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(
                            height: 16),
                        Text(
                          pages[index]
                              ["subtitle"]!,
                          style:
                              const TextStyle(
                            color:
                                Colors.white70,
                            fontSize: 18,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration:
                      const Duration(
                          milliseconds: 300),
                  margin:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 4,
                  ),
                  height: 8,
                  width: currentPage == index
                      ? 28
                      : 8,
                  decoration:
                      BoxDecoration(
                    color: currentPage ==
                            index
                        ? Colors.white
                        : Colors.white38,
                    borderRadius:
                        BorderRadius
                            .circular(
                                20),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 58,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.white,
                  foregroundColor:
                      Colors.black,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius
                            .circular(18),
                  ),
                ),
                onPressed: () {
                  Navigator
                      .pushReplacementNamed(
                    context,
                    AppRoutes.login,
                  );
                },
                child: const Text(
                  "Start Exploring",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}