import 'package:flutter/material.dart';
import 'package:smart_itinerary_planner/widgets/app_bar.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../services/recommendation_service.dart';
import '../models/recommendation_model.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

const String baseUrl = 'http://127.0.0.1:8000';

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const AppBottomNavBar(selectedIndex: 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchSection(),
            CategoryChips(),
            PopularDestinationsSection(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search destinations...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: const Color(0xFFF4F3F2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(
                Icons.location_on,
                color: Color(0xFF8D4B00),
              ),
              SizedBox(width: 4),
              Text(
                "Near Chhatrapati Sambhajinagar",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryChips extends StatelessWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    final chips = [
      "Popular",
      "Weekend",
      "Heritage",
      "Food",
      "Budget",
    ];

    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Chip(
            label: Text(chips[index]),
            backgroundColor:
                index == 0 ? const Color(0xFF8D4B00) : const Color(0xFF86F2E4),
            labelStyle: TextStyle(
              color: index == 0 ? Colors.white : const Color(0xFF006F66),
            ),
          );
        },
      ),
    );
  }
}

class PopularDestinationsSection extends StatefulWidget {
  const PopularDestinationsSection({
    super.key,
  });

  @override
  State<PopularDestinationsSection> createState() =>
      _PopularDestinationsSectionState();
}

class _PopularDestinationsSectionState
    extends State<PopularDestinationsSection> {
  final RecommendationApiService api = RecommendationApiService();

  List<RecommendationModel> destinations = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDestinations();
  }

  Future<void> loadDestinations() async {
    try {
      final data = await api.getPopularDestinations();

      print("LOADED DESTINATIONS = ${data.length}");

      for (var item in data) {
        print(item.title);
      }

      setState(() {
        destinations = data;
        isLoading = false;
      });
    } catch (e) {
      print("Explore Error: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 2;

    if (screenWidth > 1400) {
      crossAxisCount = 5;
    } else if (screenWidth > 1000) {
      crossAxisCount = 4;
    } else if (screenWidth > 700) {
      crossAxisCount = 3;
    }

    if (isLoading) {
      return const SizedBox(
        height: 400,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (destinations.isEmpty) {
      return const SizedBox(
        height: 400,
        child: Center(
          child: Text(
            "No destinations found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Popular Destinations",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: destinations.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.78,
            ),
            itemBuilder: (context, index) {
              final destination = destinations[index];

              return Card(
                elevation: 6,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Image.network(
                        destination.thumbnail,
                        fit: BoxFit.cover,
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
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(
                                Icons.image,
                                size: 60,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              destination.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              destination.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                              ),
                            ),
                            const Spacer(),
                            if (destination.flightPrice.isNotEmpty)
                              Text(
                                "✈ ${destination.flightPrice}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            if (destination.hotelPrice.isNotEmpty)
                              Text(
                                "🏨 ${destination.hotelPrice}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final RecommendationModel destination;

  const DestinationCard({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/destination-details',
            arguments: destination
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Image.network(
                    destination.thumbnail,
                    fit: BoxFit.cover,
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
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            size: 60,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      destination.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        if (destination.flightPrice.isNotEmpty)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "✈ ${destination.flightPrice}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        if (destination.flightPrice.isNotEmpty &&
                            destination.hotelPrice.isNotEmpty)
                          const SizedBox(width: 8),
                        if (destination.hotelPrice.isNotEmpty)
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "🏨 ${destination.hotelPrice}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
