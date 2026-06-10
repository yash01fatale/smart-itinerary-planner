import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_itinerary_planner/config/app_routes.dart';
import 'package:smart_itinerary_planner/screens/intialScreens/profile/edit_profile.dart';

import '../../../widgets/app_bottom_nav_bar.dart';
import '../../../widgets/app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xffF4FAFF),
      appBar: const CustomAppBar(
        showBackButton: false,
      ),
      bottomNavigationBar: const AppBottomNavBar(selectedIndex: 4),

      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text("Profile not found"),
            );
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          final name = data['name'] ?? 'Unknown User';
          final email = data['email'] ?? '';
          final photoUrl = data['photoUrl'] ?? '';
          final bio = data['bio'] ?? 'No bio available';

          return SingleChildScrollView(
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
                            backgroundImage: photoUrl.isNotEmpty
                                ? NetworkImage(photoUrl)
                                : null,
                            child: photoUrl.isEmpty
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                  )
                                : null,
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
                              child: Text(
                                "PRO Travelleer",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        bio,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                Icon(Icons.calendar_today, size: 16),
                                SizedBox(width: 5),
                                Text("Oct 12 - Oct 19"),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Row(
                              children: [
                                Icon(Icons.location_on, size: 16),
                                SizedBox(width: 5),
                                Text("Male, Maldives"),
                              ],
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0EA5E9),
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
                      _settingTile(Icons.edit, "Edit Profile", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EditProfileScreen(),
                          ),
                        );
                      }),
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
  onTap: () async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Log Out"),
        content: const Text(
          "Are you sure you want to log out?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Log Out"),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      await FirebaseAuth.instance.signOut();

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        );
      }
    }
  },
),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
