import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/day_plan.dart';

class ItineraryScreen extends StatelessWidget {
  final List<DayPlan> itinerary;

  const ItineraryScreen({
    super.key,
    required this.itinerary,
  });

  Future<void> _openDirections(String address) async {
    final url = Uri.parse(
      "https://www.google.com/maps/dir/?api=1&destination=${Uri.encodeComponent(address)}",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        title: const Text(
          "Trip Itinerary",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      bottomNavigationBar: itinerary.isEmpty
          ? null
          : BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.navigation),
                  label: const Text(
                    "Start Navigation",
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                  ),
                  onPressed: () async {
                    final firstPlace =
                        itinerary.first.places.first;

                    await _openDirections(
                      firstPlace.address,
                    );
                  },
                ),
              ),
            ),

      body: ListView.builder(
        itemCount: itinerary.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final dayPlan = itinerary[index];

          return Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.only(bottom: 12),
                child: Text(
                  "Day ${dayPlan.day}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              ...dayPlan.places.map(
                (place) => Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  margin:
                      const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      if (place.thumbnail.isNotEmpty)
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.network(
                            place.thumbnail,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,

                            loadingBuilder: (
                              context,
                              child,
                              loadingProgress,
                            ) {
                              if (loadingProgress ==
                                  null) {
                                return child;
                              }

                              return Container(
                                height: 200,
                                alignment:
                                    Alignment.center,
                                child:
                                    const CircularProgressIndicator(),
                              );
                            },

                            errorBuilder: (
                              context,
                              error,
                              stackTrace,
                            ) {
                              return Container(
                                height: 200,
                                width: double.infinity,
                                color:
                                    Colors.grey.shade200,
                                child: const Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                  children: [
                                    Icon(
                                      Icons
                                          .image_not_supported,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Image not available",
                                      style: TextStyle(
                                        color:
                                            Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      else
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius:
                                const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo,
                                size: 50,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "No image available",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                      Padding(
                        padding:
                            const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.name,
                              style:
                                  const TextStyle(
                                fontSize: 20,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    place.address,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Text(
                              "⭐ ${place.rating} (${place.reviews} reviews)",
                              style: TextStyle(
                                color:
                                    Colors.grey.shade700,
                              ),
                            ),

                            const SizedBox(height: 16),

                            SizedBox(
                              width: double.infinity,
                              child:
                                  ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.navigation,
                                ),
                                label: const Text(
                                  "Navigate",
                                ),
                                onPressed: () async {
                                  await _openDirections(
                                    place.address,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}