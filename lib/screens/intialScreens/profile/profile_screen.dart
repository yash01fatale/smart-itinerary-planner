import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Icon(
              Icons.explore,
              color: Color(0xFF006591),
            ),
            SizedBox(width: 8),
            Text(
              "TravelWise AI",
              style: TextStyle(
                color: Color(0xFF006591),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1500648767791-00dcc994a43",
              ),
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFBBF24),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),

     

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            /// Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black12,
                  )
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: const NetworkImage(
                          "https://images.unsplash.com/photo-1500648767791-00dcc994a43",
                        ),
                      ),
                      Positioned(
                        bottom: -5,
                        right: -5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBBF24),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Pro Traveler",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Alex Explorer",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Adventure seeker and mountain lover. Always looking for the next hidden gem. Passionate about sustainable travel and capturing landscapes through my lens.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _statCard("12", "Trips"),
                      _statCard("45", "Places"),
                      _statCard("2.4k km", "Travelled"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// Interests
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Interests",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                Chip(
                  label: Text("Hill Stations"),
                  avatar: Icon(Icons.terrain, size: 18),
                ),
                Chip(
                  label: Text("Beach Life"),
                  avatar: Icon(Icons.beach_access, size: 18),
                ),
                Chip(
                  label: Text("Historical Sites"),
                  avatar: Icon(Icons.castle, size: 18),
                ),
                Chip(
                  label: Text("Solo Travel"),
                  avatar: Icon(Icons.directions_walk, size: 18),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// Recent Activity
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("View All"),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1573843981267-be1999ff37cd",
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Maldives Tropical Escape",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 16),
                            SizedBox(width: 5),
                            Text("Oct 12 - Oct 19"),
                          ],
                        ),

                        const SizedBox(height: 5),

                        const Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 16),
                            SizedBox(width: 5),
                            Text("Male, Maldives"),
                          ],
                        ),

                        const SizedBox(height: 15),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF0EA5E9),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "View Details",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// Account Settings
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _settingTile(
                    Icons.edit,
                    "Edit Profile",
                  ),
                  _settingTile(
                    Icons.payment,
                    "Payment Methods",
                  ),
                  _settingTile(
                    Icons.tune,
                    "Travel Preferences",
                  ),
                  _settingTile(
                    Icons.notifications,
                    "Notification Settings",
                  ),
                  _settingTile(
                    Icons.help,
                    "Help & Support",
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    title: const Text(
                      "Log Out",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _statCard(String value, String label) {
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF006591),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(label),
        ],
      ),
    );
  }

  static Widget _settingTile(
      IconData icon,
      String title,
      ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(
        Icons.chevron_right,
      ),
      onTap: () {},
    );
  }
}