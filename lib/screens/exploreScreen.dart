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

class _ExploreScreenState extends State<ExploreScreen> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const CustomAppBar(),
      bottomNavigationBar: const AppBottomNavBar(selectedIndex: 1),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SearchSection(),
            CategoryChips(),
            WeekendGetawaysSection(),
            // HiddenGemsSection(),
            // HeritageSection(),
            // FoodCafeSection(),
            // BackpackerGuideSection(),
            SizedBox(height: 80),
          ],
        ),
      ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     currentIndex: currentIndex,
    //     selectedItemColor: Color(0xFF006A61),
    //     unselectedItemColor: Colors.grey,
    //     onTap: (i) {
    //       setState(() {
    //         currentIndex = i;
    //       });
    //     },
    //     items: const [
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home),
    //         label: 'Home',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.explore),
    //         label: 'Explore',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.bookmark),
    //         label: 'Saved',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.person),
    //         label: 'Profile',
    //       ),
    //     ],
    //   ),
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
              hintText: "Search destinations, tours...",
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
      "Weekend Getaways",
      "Hidden Gems",
      "Heritage",
      "Food & Cafe",
      "Budget Guides",
    ];

    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
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

class WeekendGetawaysSection extends StatefulWidget {
  const WeekendGetawaysSection({super.key});

  @override
  State<WeekendGetawaysSection> createState() =>
      _WeekendGetawaysSectionState();
}

class _WeekendGetawaysSectionState
    extends State<WeekendGetawaysSection> {
  final RecommendationApiService api =
      RecommendationApiService();

  List<RecommendationModel> destinations = [];

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
        height: 250,
        child: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    if (destinations.isEmpty) {
      return const SizedBox(
        height: 250,
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
              fontSize: 28,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),

        SizedBox(
          height: 300,

          child: ListView.builder(
            scrollDirection:
                Axis.horizontal,

            itemCount:
                destinations.length,

            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
            ),

            itemBuilder:
                (context, index) {
              final place =
                  destinations[index];

              return Padding(
                padding:
                    const EdgeInsets.only(
                  right: 16,
                ),

                child: DestinationCard(
                  title: place.title,
                  subtitle:
                      place.description,
                  imageUrl:
                      place.thumbnail,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const DestinationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,

      child: Card(
        elevation: 4,

        clipBehavior:
            Clip.antiAlias,

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16),
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Expanded(
              child: Image.network(
                imageUrl,

                width:
                    double.infinity,

                fit: BoxFit.cover,

                errorBuilder:
                    (context,
                        error,
                        stackTrace) {
                  return Container(
                    color:
                        Colors.grey.shade200,

                    child: const Center(
                      child: Icon(
                        Icons.image,
                        size: 50,
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
                    title,

                    maxLines: 1,

                    overflow:
                        TextOverflow.ellipsis,

                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                    height: 4,
                  ),

                  Text(
                    subtitle,

                    maxLines: 2,

                    overflow:
                        TextOverflow.ellipsis,

                    style:
                        TextStyle(
                      color:
                          Colors.grey[700],
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