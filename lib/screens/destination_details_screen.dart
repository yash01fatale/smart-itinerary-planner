import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/recommendation_model.dart';

class DestinationDetails extends StatelessWidget {
  const DestinationDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final destination =
        ModalRoute.of(context)!.settings.arguments as RecommendationModel;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: Colors.teal,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                destination.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              background: Hero(
                tag: destination.title,
                child: Image.network(
                  destination.thumbnail,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  loadingBuilder: (
                    context,
                    child,
                    progress,
                  ) {
                    if (progress == null) {
                      return child;
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          size: 100,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination.title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    destination.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            destination.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Expanded(
                        child: _infoCard(
                          Icons.flight,
                          "Flight",
                          destination.flightPrice.isEmpty
                              ? "N/A"
                              : destination.flightPrice,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: _infoCard(
                          Icons.hotel,
                          "Hotel",
                          destination.hotelPrice.isEmpty
                              ? "N/A"
                              : destination.hotelPrice,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "AI Travel Summary",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    child: Text(
                      "${destination.title} is one of India's most popular travel destinations. Explore cultural heritage, famous landmarks, local cuisine, shopping areas, beautiful sightseeing spots and memorable travel experiences.",
                      style: const TextStyle(
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Best Time To Visit",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "October to March is generally considered the best season for tourism due to pleasant weather and outdoor activities.",
                    style: TextStyle(
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Quick Facts",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: const [
                      Chip(
                        label: Text(
                          "Family Friendly",
                        ),
                      ),
                      Chip(
                        label: Text(
                          "Photography",
                        ),
                      ),
                      Chip(
                        label: Text(
                          "Food",
                        ),
                      ),
                      Chip(
                        label: Text(
                          "Shopping",
                        ),
                      ),
                      Chip(
                        label: Text(
                          "Tourist Spot",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Top Attractions",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      "Famous Landmark",
                      "Historic Site",
                      "Local Market",
                      "Food Street",
                      "Scenic Spot",
                    ]
                        .map(
                          (e) => Chip(
                            avatar: const Icon(
                              Icons.place,
                              size: 18,
                            ),
                            label: Text(e),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Things To Do",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        title: Text(
                          "Sightseeing",
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        title: Text(
                          "Photography",
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        title: Text(
                          "Food Exploration",
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        title: Text(
                          "Shopping",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.map,
                          ),
                          label: const Text(
                            "Explore",
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/explore',
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.travel_explore,
                          ),
                          label: const Text(
                            "Plan Trip",
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/tripInput',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(
    IconData icon,
    String title,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(value),
        ],
      ),
    );
  }
}
