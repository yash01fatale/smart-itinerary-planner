import 'package:flutter/material.dart';
import 'package:smart_itinerary_planner/widgets/app_bar.dart';
import '../widgets/app_bottom_nav_bar.dart';

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

class WeekendGetawaysSection extends StatelessWidget {
  const WeekendGetawaysSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Weekend Getaways",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        SizedBox(
          height: 280,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              DestinationCard(
                title: "Ellora & Ajanta",
                subtitle: "Ancient Wonders",
                imageUrl: "IMAGE_URL",
              ),
              SizedBox(width: 16),
              DestinationCard(
                title: "Nashik Vineyards",
                subtitle: "Wine & Relaxation",
                imageUrl: "IMAGE_URL",
              ),
              SizedBox(width: 16),
              DestinationCard(
                title: "Lonavala",
                subtitle: "Misty Hills",
                imageUrl: "IMAGE_URL",
              ),
            ],
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
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(subtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}