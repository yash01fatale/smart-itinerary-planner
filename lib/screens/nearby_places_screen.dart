import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyPlacesScreen extends StatelessWidget {
  const NearbyPlacesScreen({super.key});

  Future<void> openMaps(String place) async {
    final Uri url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$place",
    );

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final destination =
        ModalRoute.of(context)?.settings.arguments as String? ?? "Goa";

    final nearbyPlaces = [
      {
        "name": "Fort Aguada",
        "distance": "5 km",
        "category": "Fort",
        "image": "https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86",
      },
      {
        "name": "Baga Beach",
        "distance": "3 km",
        "category": "Beach",
        "image": "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
      },
      {
        "name": "Dudhsagar Falls",
        "distance": "45 km",
        "category": "Waterfall",
        "image": "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
      },
      {
        "name": "Chapora Fort",
        "distance": "12 km",
        "category": "Historical",
        "image": "https://images.unsplash.com/photo-1469474968028-56623f02e42e",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nearby Places - $destination",
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: nearbyPlaces.length,
        itemBuilder: (context, index) {
          final place = nearbyPlaces[index];

          return Card(
            margin: const EdgeInsets.only(
              bottom: 15,
            ),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: Image.network(
                    place["image"]!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place["name"]!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Chip(
                            label: Text(
                              place["category"]!,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            place["distance"]!,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          openMaps(
                            place["name"]!,
                          );
                        },
                        icon: const Icon(
                          Icons.map,
                        ),
                        label: const Text(
                          "Open in Maps",
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/nearby-places',
                            arguments: destination,
                          );
                        },
                        icon: const Icon(Icons.place),
                        label: const Text(
                          "Nearby Places",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
