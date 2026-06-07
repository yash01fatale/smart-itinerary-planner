import 'package:flutter/material.dart';

class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({super.key});

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
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffFBBF24),
        onPressed: () {},
        child: const Icon(Icons.map),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        destinations: const [
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// Weather Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.sunny,
                        color: Colors.orange,
                        size: 40,
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            "24°C",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Sunny • Tokyo, Japan"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Safety & Precautions",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  BulletText("High UV today; wear sunscreen."),
                  BulletText("Stay hydrated."),
                  BulletText("Carry a light jacket."),
                  BulletText("Use public transport."),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Your 3-Day Journey",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Day 1
            ExpansionTile(
              initiallyExpanded: true,
              title: const Text(
                "Day 1: Cultural Landmarks",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                "4 Spots • 12.5 km",
              ),
              children: const [
                PlaceCard(
                  image:
                      "https://images.unsplash.com/photo-1545569341-9eb8b30979d9",
                  title: "Senso-ji Temple",
                  description:
                      "Tokyo's oldest temple and shopping street.",
                  time: "09:00 AM",
                ),
                PlaceCard(
                  image:
                      "https://images.unsplash.com/photo-1503899036084-c55cdd92da26",
                  title: "Shibuya Crossing",
                  description:
                      "World's busiest crossing and lunch spot.",
                  time: "12:30 PM",
                ),
                PlaceCard(
                  image:
                      "https://images.unsplash.com/photo-1526481280695-3c469dca1e5c",
                  title: "Meiji Shrine",
                  description:
                      "Peaceful forest shrine in Tokyo.",
                  time: "03:00 PM",
                ),
              ],
            ),

            /// Day 2
            ExpansionTile(
              title: const Text(
                "Day 2: Modern Tokyo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                "3 Spots • 15 km",
              ),
              children: const [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Modern city attractions and shopping districts.",
                  ),
                ),
              ],
            ),

            /// Day 3
            ExpansionTile(
              title: const Text(
                "Day 3: Nature & Parks",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                "3 Spots • 8 km",
              ),
              children: const [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Parks, gardens and nature escapes.",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class BulletText extends StatelessWidget {
  final String text;

  const BulletText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• "),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String time;

  const PlaceCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(
                  image,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Text(
                    time,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            title: Text(title),
            subtitle: Text(description),
            trailing: TextButton(
              onPressed: () {},
              child: const Text("View Map"),
            ),
          ),
        ],
      ),
    );
  }
}