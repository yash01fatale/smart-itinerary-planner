import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  final TextEditingController searchController = TextEditingController();
  String selectedCategory = "Popular";
  List<RecommendationModel> searchResults = [];

  bool isSearching = false;
  Future<void> searchDestination(
    String query,
  ) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    setState(() {
      isSearching = true;
    });

    try {
      final result = await RecommendationApiService().searchDestinations(query);

      setState(() {
        searchResults = result;
        isSearching = false;
      });
    } catch (e) {
      setState(() {
        isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const AppBottomNavBar(selectedIndex: 1),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                searchDestination(value);
              },
              decoration: InputDecoration(
                hintText: "Search Any Destination...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          CategoryChips(
  selectedCategory: selectedCategory ?? "Popular",
            onCategorySelected: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
          ),
          searchController.text.isNotEmpty
              ? SearchResultsSection(
                  destinations: searchResults,
                )
              : PopularDestinationsSection(
                  category: selectedCategory,
                ),
        ]),
      ),
    );
  }
}

class CategoryChips extends StatelessWidget {
final String? selectedCategory;

  final Function(String) onCategorySelected;

  const CategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

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
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        itemCount: chips.length,
        itemBuilder: (context, index) {
          final category = chips[index];

final isSelected =
    category == (selectedCategory ?? "Popular");
          return Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (_) {
                onCategorySelected(category);
              },
              selectedColor: const Color(0xFF8D4B00),
              backgroundColor: const Color(0xFF86F2E4),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF006F66),
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }
}

class PopularDestinationsSection
    extends StatefulWidget {

  final String category;

  const PopularDestinationsSection({
    super.key,
    required this.category,
  });

  @override
  State<PopularDestinationsSection>
      createState() =>
          _PopularDestinationsSectionState();
}

class _PopularDestinationsSectionState
    extends State<PopularDestinationsSection> {
  final RecommendationApiService api = RecommendationApiService();

  List<RecommendationModel> destinations = [];

  bool isLoading = true;
  @override
void didUpdateWidget(
  covariant PopularDestinationsSection
      oldWidget,
) {
  super.didUpdateWidget(oldWidget);

  if (oldWidget.category !=
      widget.category) {
    loadDestinations();
  }
}

  @override
  void initState() {
    super.initState();
    loadDestinations();
  }

  Future<void> loadDestinations() async {
    try {
      final data = await api.getPopularDestinations();
      List<RecommendationModel> filtered =
    data;

switch (widget.category) {
  case "Weekend":
    filtered = data
        .where((e) =>
            e.title.contains("Goa") ||
            e.title.contains("Udaipur"))
        .toList();
    break;

  case "Heritage":
    filtered = data
        .where((e) =>
            e.title.contains("Agra") ||
            e.title.contains("Jaipur") ||
            e.title.contains("Varanasi"))
        .toList();
    break;

  case "Food":
    filtered = data
        .where((e) =>
            e.title.contains("Mumbai") ||
            e.title.contains("Delhi"))
        .toList();
    break;

  case "Budget":
    filtered = data
        .where((e) =>
            e.hotelPrice.isNotEmpty)
        .toList();
    break;

  default:
    filtered = data;
}

      setState(() {
        destinations = filtered;
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
          const SizedBox(
            height: 20,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: destinations.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (context, index) {
              return DestinationCard(
                destination: destinations[index],
              );
            },
          ),
        ],
      ),
    );
  }
}

class SearchResultsSection extends StatelessWidget {
  final List<RecommendationModel> destinations;

  const SearchResultsSection({
    super.key,
    required this.destinations,
  });

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

    if (destinations.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(30),
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
            "Search Results",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "${destinations.length} destinations found",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: destinations.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (context, index) {
              return DestinationCard(
                destination: destinations[index],
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
            arguments: destination,
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
                    width: double.infinity,
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
