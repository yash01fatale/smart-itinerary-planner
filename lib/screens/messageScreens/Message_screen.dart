import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/app_bottom_nav_bar.dart';
import '../../widgets/app_bar.dart';
import 'chatScreen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _searchController = TextEditingController();

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     extendBodyBehindAppBar: true,
  backgroundColor: const Color(0xffF4FAFF),

      appBar: const CustomAppBar(
        showBackButton: false,
      ),
      bottomNavigationBar: const AppBottomNavBar(
        selectedIndex: 1,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          /// HEADER
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
          ),

          const SizedBox(height: 50),

          /// SEARCH BAR
         Container(
  margin: const EdgeInsets.symmetric(horizontal: 20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.05),
        blurRadius: 12,
      ),
    ],
  ),
  child: TextField(
    controller: _searchController,
    onChanged: (value) {
      setState(() {
        searchText = value.toLowerCase();
      });
    },
    decoration: const InputDecoration(
      hintText: "Search travelers...",
      prefixIcon: Icon(
        Icons.travel_explore,
        color: Color(0xff0083B0),
      ),
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(
        vertical: 18,
      ),
    ),
  ),
),
          const SizedBox(height: 15),

          /// USERS LIST
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Users Found",
                    ),
                  );
                }

                final currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser == null) {
                  return const Center(
                    child: Text('Please sign in to see users.'),
                  );
                }

                final currentUserId = currentUser.uid;
                final users = snapshot.data!.docs;
                final normalizedSearch = searchText.trim().toLowerCase();

                final filteredUsers = users.where((doc) {
                  final data = doc.data() as Map<String, dynamic>? ?? {};
                  final uid = data['uid'] ?? '';
                  final name = (data['name'] ?? '').toString().toLowerCase();
                  final email = (data['email'] ?? '').toString().toLowerCase();

                  if (uid == currentUserId) {
                    return false;
                  }
                  if (normalizedSearch.isEmpty) {
                    return true;
                  }

                  return name.contains(normalizedSearch) ||
                      email.contains(normalizedSearch);
                }).toList();

                if (filteredUsers.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Users Found",
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];

                    final data = user.data() as Map<String, dynamic>;

                    final userId = user.id;

                    final name = data['name'] ?? 'Unknown User';
                    final isSelf =
                        userId == FirebaseAuth.instance.currentUser?.uid;
                    final email = data['email'] ?? '';
                    final photoUrl = data['photoUrl'] ?? '';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xffF8FBFF),
                            Color(0xffEAF6FF),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                receiverId: userId,
                                receiverName: name,
                                receiverPhoto: photoUrl,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 34,
                                    backgroundColor: Colors.white,
                                    backgroundImage: photoUrl.isNotEmpty
                                        ? NetworkImage(photoUrl)
                                        : null,
                                    child: photoUrl.isEmpty
                                        ? const Icon(
                                            Icons.person,
                                            size: 35,
                                          )
                                        : null,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      height: 14,
                                      width: 14,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              const SizedBox(
                                width: 16,
                              ),

                              /// Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      email,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // chat Screen
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xff00B4DB),
                                      Color(0xff0083B0),
                                    ],
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.send_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      "Chat",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
