import 'package:flutter/material.dart';

class SavedTripsScreen extends StatefulWidget {
  const SavedTripsScreen({super.key});

  @override
  State<SavedTripsScreen> createState() => _SavedTripsScreenState();
}

class _SavedTripsScreenState extends State<SavedTripsScreen> {
  bool isUpcoming = true;

  final List<Map<String, dynamic>> trips = [
    {
      "title": "3-Day Tokyo Exploration",
      "date": "May 12, 2024",
      "description":
          "A neon-soaked journey through futuristic architecture and ancient shrines.",
      "spots": "12 Spots",
      "days": "3 Days",
      "tag": "AI Generated",
      "image":
          "https://images.unsplash.com/photo-1540959733332-eab4deabeeaf",
    },
    {
      "title": "Maldives Tropical Escape",
      "date": "Apr 28, 2024",
      "description":
          "Ultimate relaxation among turquoise lagoons and luxury water villas.",
      "spots": "8 Spots",
      "days": "5 Days",
      "tag": "Solo Travel",
      "image":
          "https://images.unsplash.com/photo-1573843981267-be1999ff37cd",
    },
    {
      "title": "Parisian Spring Walk",
      "date": "Apr 15, 2024",
      "description":
          "A curated walk through the historic Le Marais and Seine riverbanks.",
      "spots": "15 Spots",
      "days": "2 Days",
      "tag": "",
      "image":
          "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
    },
    {
      "title": "Swiss Alpine Adventure",
      "date": "Mar 30, 2024",
      "description":
          "Hiking trails and panoramic train rides through the Alps.",
      "spots": "10 Spots",
      "days": "4 Days",
      "tag": "",
      "image":
          "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage("https://i.pravatar.cc/300"),
            ),
          )
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Collections",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "Personalized itineraries curated by your AI assistant.",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius:
                        BorderRadius.circular(12),
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
                ),

                const SizedBox(height: 20),

                TextField(
                  decoration: InputDecoration(
                    hintText:
                        "Search saved destinations...",
                    prefixIcon:
                        const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16),
              itemCount: trips.length + 1,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.15,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                if (index == trips.length) {
                  return _buildNewTripCard();
                }

                final trip = trips[index];

                return _buildTripCard(trip);
              },
            ),
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
          color:
              selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selected
                ? const Color(0xff006591)
                : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildTripCard(Map<String, dynamic> trip) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.network(
                    trip["image"],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.bookmark,
                      color: const Color(0xff006591),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  trip["title"],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  trip["description"],
                  style:
                      const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 16),
                    Text(trip["spots"]),
                    const SizedBox(width: 15),
                    const Icon(Icons.calendar_today,
                        size: 16),
                    Text(trip["days"]),
                  ],
                ),

                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward,
                    ),
                    label: const Text("View"),
                  ),
                )
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
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor:
                  const Color(0xff006591).withOpacity(.1),
              child: const Icon(
                Icons.add_location_alt,
                size: 40,
                color: Color(0xff006591),
              ),
            ),

            const SizedBox(height: 20),

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
                backgroundColor:
                    const Color(0xffFBBF24),
              ),
              onPressed: () {},
              child: const Text(
                "Start Planning",
                style:
                    TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}