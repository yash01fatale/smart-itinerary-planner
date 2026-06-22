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
  final ValueNotifier<String> searchNotifier = ValueNotifier('');
  
  @override
  void dispose() {
    _searchController.dispose();
    searchNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xffF4FAFF),
      appBar: const CustomAppBar(),
      bottomNavigationBar: const AppBottomNavBar(
        selectedIndex: 2,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4FC3F7),
              Color(0xFFE3F2FD),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
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

              final currentUser = FirebaseAuth.instance.currentUser;

              if (currentUser == null) {
                return const Center(
                  child: Text('Please sign in to continue'),
                );
              }

              final currentUserId = currentUser.uid;
              final users = snapshot.data?.docs ?? [];

              // Listen to real-time keystrokes to filter the Firestore data reactively
              return ValueListenableBuilder<String>(
                valueListenable: searchNotifier,
                builder: (context, currentSearchText, child) {
                  final filteredUsers = users.where((doc) {
                    final data = doc.data() as Map<String, dynamic>? ?? {};
                    final uid = data['uid'] ?? '';

                    if (uid == currentUserId) {
                      return false;
                    }

                    final name = (data['name'] ?? '').toString().toLowerCase();
                    final email = (data['email'] ?? '').toString().toLowerCase();

                    if (currentSearchText.trim().isEmpty) {
                      return true;
                    }

                    return name.contains(currentSearchText) || email.contains(currentSearchText);
                  }).toList();

                  // The layout needs to be returned INSIDE the ValueListenableBuilder's builder function
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      /// Header
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 10),
                      ),

                      /// Search Bar
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFF0288D1).withValues(alpha: .1),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF0288D1).withValues(alpha: .1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                searchNotifier.value = value.toLowerCase();
                              },
                              decoration: const InputDecoration(
                                hintText: "Search travelers...",
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xFF0288D1),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 18),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SliverToBoxAdapter(
                        child: SizedBox(height: 20),
                      ),

                      /// Users List
                      if (filteredUsers.isEmpty)
                        const SliverFillRemaining(
                          child: Center(
                            child: Text(
                              "No Travelers Found",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      else
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final user = filteredUsers[index];
                              final data = user.data() as Map<String, dynamic>;
                              final userId = user.id;

                              final name = data['name'] ?? 'Unknown User';
                              final email = data['email'] ?? '';
                              final photoUrl = data['photoUrl'] ?? '';

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(22),
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
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(22),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF0288D1).withValues(alpha: .08),
                                          blurRadius: 20,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        /// Avatar
                                        Stack(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: const Color(0xFF03A9F4),
                                                  width: 2,
                                                ),
                                              ),
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.white,
                                                backgroundImage: photoUrl.isNotEmpty
                                                    ? NetworkImage(photoUrl)
                                                    : null,
                                                child: photoUrl.isEmpty
                                                    ? const Icon(
                                                        Icons.person,
                                                        size: 30,
                                                      )
                                                    : null,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 2,
                                              right: 2,
                                              child: Container(
                                                height: 12,
                                                width: 12,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 16),

                                        /// User Info
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name,
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFF1A1A1A),
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              const Text(
                                                "Travel Enthusiast",
                                                style: TextStyle(
                                                  color: Color(0xFF0288D1),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
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

                                        /// Chat Button
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF03A9F4),
                                                Color(0xFF0288D1),
                                              ],
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.send_rounded,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: filteredUsers.length,
                          ),
                        ),

                      const SliverToBoxAdapter(
                        child: SizedBox(height: 90),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}