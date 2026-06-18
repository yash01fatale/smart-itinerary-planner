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

  const String baseUrl =
    'http://localhost:8000';

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar:
          const AppBottomNavBar(selectedIndex: 1),

      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
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
              hintText:
                  "Search destinations...",
              prefixIcon:
                  const Icon(Icons.search),
              filled: true,
              fillColor:
                  const Color(0xFFF4F3F2),
              border:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(30),
                borderSide:
                    BorderSide.none,
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
        scrollDirection:
            Axis.horizontal,
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        itemCount: chips.length,
        separatorBuilder:
            (_, __) =>
                const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Chip(
            label: Text(chips[index]),
            backgroundColor: index == 0
                ? const Color(0xFF8D4B00)
                : const Color(0xFF86F2E4),
            labelStyle: TextStyle(
              color: index == 0
                  ? Colors.white
                  : const Color(0xFF006F66),
            ),
          );
        },
      ),
    );
  }
}

class PopularDestinationsSection
    extends StatefulWidget {
  const PopularDestinationsSection({
    super.key,
  });

  @override
  State<PopularDestinationsSection>
      createState() =>
          _PopularDestinationsSectionState();
}

class _PopularDestinationsSectionState
    extends State<
        PopularDestinationsSection> {
  final RecommendationApiService api =
      RecommendationApiService();

  List<RecommendationModel>
      destinations = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDestinations();
  }

  Future<void> loadDestinations() async {
  try {
    final data =
        await api.getPopularDestinations();

    print(
        "LOADED DESTINATIONS = ${data.length}");

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
    if (isLoading) {
      return const SizedBox(
        height: 300,
        child: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    if (destinations.isEmpty) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: Text(
            "No destinations found",
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Popular Destinations",
            style: TextStyle(
              fontSize: 26,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),

        SizedBox(
          height: 320,
          child: ListView.builder(
            scrollDirection:
                Axis.horizontal,
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            itemCount:
                destinations.length,
            itemBuilder:
                (context, index) {
              final place =
                  destinations[index];

              return Padding(
                padding:
                    const EdgeInsets.only(
                  right: 16,
                ),
                child:
                    DestinationCard(
                  destination: place,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class DestinationCard
    extends StatelessWidget {
  final RecommendationModel
      destination;

  const DestinationCard({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Card(
        elevation: 5,
        clipBehavior:
            Clip.antiAlias,
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                destination.thumbnail,
                width:
                    double.infinity,
                fit: BoxFit.cover,

                loadingBuilder: (
                  context,
                  child,
                  progress,
                ) {
                  if (progress ==
                      null) {
                    return child;
                  }

                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                },

                errorBuilder:
                    (
                      context,
                      error,
                      stackTrace,
                    ) {
                  return Container(
                    color:
                        Colors.grey[300],
                    child:
                        const Center(
                      child: Icon(
                        Icons.image,
                        size: 60,
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    destination.title,
                    maxLines: 1,
                    overflow:
                        TextOverflow
                            .ellipsis,
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  Text(
                    destination
                        .description,
                    maxLines: 2,
                    overflow:
                        TextOverflow
                            .ellipsis,
                    style:
                        TextStyle(
                      color:
                          Colors.grey[
                              700],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  if (destination
                      .flightPrice
                      .isNotEmpty)
                    Text(
                      "✈ ${destination.flightPrice}",
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                    ),

                  if (destination
                      .hotelPrice
                      .isNotEmpty)
                    Text(
                      "🏨 ${destination.hotelPrice}",
                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}