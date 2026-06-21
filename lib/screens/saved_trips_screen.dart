import 'package:flutter/material.dart';
import 'package:smart_itinerary_planner/widgets/app_bar.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'package:share_plus/share_plus.dart';

class SavedTripsScreen extends StatefulWidget {
  const SavedTripsScreen({super.key});

  @override
  State<SavedTripsScreen> createState() => _SavedTripsScreenState();
}

class _SavedTripsScreenState extends State<SavedTripsScreen> {
  bool isUpcoming = true;
  String searchText = "";
  List<Map<String, dynamic>> get filteredTrips {
    return trips.where((trip) {
      final title = (trip["title"] ?? "").toString().toLowerCase();

      final description = (trip["description"] ?? "").toString().toLowerCase();

      final query = (searchText).toString().toLowerCase();

      return title.contains(query) || description.contains(query);
    }).toList();
  }

  final List<Map<String, dynamic>> trips = [
    {
      "title": "3-Day Tokyo Exploration",
      "date": "May 12, 2024",
      "description":
          "A neon-soaked journey through futuristic architecture and ancient shrines.",
      "spots": "12 Spots",
      "days": "3 Days",
      "tag": "AI Generated",
      "image": "https://images.unsplash.com/photo-1540959733332-eab4deabeeaf",
    },
    {
      "title": "Maldives Tropical Escape",
      "date": "Apr 28, 2024",
      "description":
          "Ultimate relaxation among turquoise lagoons and luxury water villas.",
      "spots": "8 Spots",
      "days": "5 Days",
      "tag": "Solo Travel",
      "image": "https://images.unsplash.com/photo-1573843981267-be1999ff37cd",
    },
    {
      "title": "Parisian Spring Walk",
      "date": "Apr 15, 2024",
      "description":
          "A curated walk through the historic Le Marais and Seine riverbanks.",
      "spots": "15 Spots",
      "days": "2 Days",
      "tag": "",
      "image": "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
    },
    {
      "title": "Swiss Alpine Adventure",
      "date": "Mar 30, 2024",
      "description":
          "Hiking trails and panoramic train rides through the Alps.",
      "spots": "10 Spots",
      "days": "4 Days",
      "tag": "",
      "image": "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final tripData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final destination = tripData?["destination"] ?? "Goa";

    final image = tripData?["image"] ?? "";

    final description = tripData?["description"] ?? "";

    final days = tripData?["days"] ?? 3;

    final budget = tripData?["budget"] ?? 25000;

    final travelers = tripData?["travelers"] ?? 2;
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      //custom app and bottam bar
      appBar: AppBar(
        title: const Text("Saved Trips"),
      ),
      bottomNavigationBar: const SizedBox(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xffFBBF24),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/tripInput',
          );
        },
        icon: const Icon(
          Icons.add,
        ),
        label: const Text(
          "New Trip",
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Collections",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Personalized itineraries curated by your AI assistant.",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            _buildTabs(),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Trips",
                    trips.length.toString(),
                    Icons.flight_takeoff,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    "Saved",
                    "24",
                    Icons.bookmark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    "Days",
                    "42",
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search saved destinations...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...filteredTrips.map(
              (trip) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildTripCard(trip),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _tabButton(
            title: "Upcoming",
            selected: isUpcoming,
            onTap: () {
              setState(() {
                isUpcoming = true;
              });
            },
          ),
          _tabButton(
            title: "Past",
            selected: !isUpcoming,
            onTap: () {
              setState(() {
                isUpcoming = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _tabButton({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selected ? const Color(0xff006591) : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildTripCard(Map<String, dynamic> trip) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20),
            ),
            child: Image.network(
              trip["image"],
              width: 180,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip["title"],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    trip["description"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.red,
                      ),
                      Text(trip["spots"]),
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: Colors.blue,
                      ),
                      Text(trip["days"]),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/itinerary',
                      arguments: {
                        "destination": trip["title"],
                        "image": trip["image"],
                        "days": 3,
                        "travelers": 2,
                        "budget": 25000,
                      },
                    );
                  },
                  icon: const Icon(Icons.visibility, size: 16),
                  label: const Text("View"),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        Share.share(
                          '''
${trip["name"]}

${trip["description"]}

Explore with TravelWise AI
      ''',
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNewTripCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade400,
          style: BorderStyle.solid,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: const Color(0xff006591).withOpacity(.1),
              child: const Icon(
                Icons.add_location_alt,
                size: 40,
                color: Color(0xff006591),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Trips",
                    trips.length.toString(),
                    Icons.flight_takeoff,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard(
                    "Countries",
                    "8",
                    Icons.public,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard(
                    "Days",
                    "42",
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
            const Text(
              "Plan a New Trip",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Let AI design your next getaway",
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFBBF24),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/trip-input',
                );
              },
              child: const Text(
                "Start Planning",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
  ) {
    return SizedBox(
      height: 100,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: const Color(0xff006591),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
