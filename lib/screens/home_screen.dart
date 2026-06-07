import 'package:flutter/material.dart';
import '../config/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {"title": "Hill Station", "icon": Icons.landscape},
    {"title": "Beach", "icon": Icons.beach_access},
    {"title": "Mountains", "icon": Icons.terrain},
    {"title": "Historical", "icon": Icons.account_balance},
  ];

  final List<Map<String, String>> recommendations = [
    {
      "title": "Kyoto Cultural Tour",
      "days": "7 Days",
      "country": "Japan",
      "image": "https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e"
    },
    {
      "title": "Cinque Terre Coastal",
      "days": "4 Days",
      "country": "Italy",
      "image": "https://images.unsplash.com/photo-1516483638261-f4dbaf036963"
    },
    {
      "title": "Swiss Alpine Retreat",
      "days": "10 Days",
      "country": "Switzerland",
      "image": "https://images.unsplash.com/photo-1506744038136-46273834b3fb"
    },
  ];

  void _goToTripInput() {
    Navigator.pushNamed(context, AppRoutes.tripInput);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.explore, color: Color(0xff006591)),
            SizedBox(width: 8),
            Text(
              "TravelWise AI",
              style: TextStyle(
                color: Color(0xff006591),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/300",
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff006591),
        elevation: 8,
        onPressed: _goToTripInput,
        icon: const Icon(
          Icons.travel_explore_sharp,
          color: Colors.white,
        ),
        label: const Text(
          "Plan Trip",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });

          if (index == 0) {
            Navigator.pushNamed(context, AppRoutes.messagesScreen);
          } else if (index == 1) {
            Navigator.pushNamed(context, AppRoutes.chatbot);
          } else if (index == 2) {
            Navigator.pushNamed(context, AppRoutes.itinerary);
          } else if (index == 3) {
            Navigator.pushNamed(context, AppRoutes.savedTrips);
          } else if (index == 4) {
            Navigator.pushNamed(context, AppRoutes.profileScreen);
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_sharp),
            label: "ChatScreen",
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: "Explore",
          ),
          NavigationDestination(
            icon: Icon(Icons.map),
            label: "Trips",
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark),
            label: "Saved",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 350,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your Next Adventure,\nAI-Perfected",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Search Destination",
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFBBF24),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 18,
                            ),
                          ),
                          onPressed: _goToTripInput,
                          child: const Text(
                            "Explore",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select Category",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("View All"),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (_, index) {
                  final category = categories[index];

                  return Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Chip(
                      avatar: Icon(
                        category["icon"],
                        color: const Color(0xff006591),
                      ),
                      label: Text(category["title"]),
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Trending Destinations",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 250,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recommended For You",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recommendations.length,
              itemBuilder: (_, index) {
                final item = recommendations[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: Image.network(
                          item["image"]!,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      ListTile(
                        title: Text(item["title"]!),
                        subtitle: Text(
                          "${item["days"]} • ${item["country"]}",
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onTap: _goToTripInput,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
