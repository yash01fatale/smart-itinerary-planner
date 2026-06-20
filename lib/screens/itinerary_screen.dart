import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({super.key});

  Future<void> openMaps(String place) async {
    final Uri url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$place",
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
    final tripData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final destination = tripData?["destination"] ?? "Goa";

    final days = tripData?["days"] ?? 3;

    final budget = tripData?["budget"] ?? 25000;

    final travelers = tripData?["travelers"] ?? 2;

    final itinerary = [
      [
        "Main Attraction",
        "City Center",
        "Local Market",
      ],
      [
        "Historic Place",
        "Museum",
        "Food Street",
      ],
      [
        "Nature Spot",
        "Sunset Point",
        "Shopping Area",
      ],
    ];

    return DefaultTabController(
      length: days,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "$destination Itinerary",
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                      ),
                      const SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          "https://source.unsplash.com/800x400/?$destination",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: Text(
                          destination,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$days Days",
                      ),
                      Text(
                        "$travelers Travelers",
                      ),
                      Text(
                        "₹$budget",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TabBar(
              isScrollable: true,
              tabs: List.generate(
                days,
                (index) => Tab(
                  text: "Day ${index + 1}",
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: List.generate(
                  days,
                  (dayIndex) {
                    final places = itinerary[dayIndex % itinerary.length];

                    return ListView.builder(
                      padding: const EdgeInsets.all(
                        15,
                      ),
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        final place = places[index];

                        return Card(
                          margin: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                              15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  place,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "A popular tourist attraction recommended for your trip.",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.route,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      "Approx. 5 km",
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    icon: const Icon(Icons.map),
                                    label: const Text(
                                      "View on Google Maps",
                                    ),
                                    onPressed: () {
                                      openMaps(
                                        "$place $destination",
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
