import 'package:flutter/material.dart';
import 'package:smart_itinerary_planner/widgets/app_bar.dart';
import './GroupScreen.dart';
import '../../widgets/app_bottom_nav_bar.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  int selectedIndex = 2;

  final List<Map<String, dynamic>> chats = [
    {
      "name": "Tokyo Explorers",
      "message":
          "Akira: Has everyone checked the JR Pass availability for next week?",
      "time": "2 min ago",
      "unread": 3,
      "online": true,
      "image": "https://images.unsplash.com/photo-1540959733332-eab4deabeeaf"
    },
    {
      "name": "Maldives 2026",
      "message": "You: Just booked the snorkeling excursion!",
      "time": "1 hour ago",
      "unread": 0,
      "online": false,
      "image": "https://images.unsplash.com/photo-1573843981267-be1999ff37cd"
    },
    {
      "name": "Family Alpine Trip",
      "message": "Mom: Remember to pack those extra thermal layers!",
      "time": "Yesterday",
      "unread": 1,
      "online": false,
      "image": "https://images.unsplash.com/photo-1506744038136-46273834b3fb"
    },
    {
      "name": "London Business Weekend",
      "message": "Sarah: The itinerary for the Friday conference is ready.",
      "time": "2 days ago",
      "unread": 0,
      "online": false,
      "image": "https://images.unsplash.com/photo-1513635269975-59663e0ac1ad"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      //Custom App Bar 
      appBar: const CustomAppBar(showBackButton : false), 


      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffFBBF24),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      //Bootam NAvigation bar 
      bottomNavigationBar: const AppBottomNavBar(selectedIndex: 1),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Your Itineraries",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Stay connected with your travel companions.",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 25),

            /// SEARCH BAR
            TextField(
              decoration: InputDecoration(
                hintText: "Search chats...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// CHAT LIST
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    elevation: 2,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  backgroundImage: NetworkImage(
                                    chat["image"],
                                  ),
                                ),
                                if (chat["online"])
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          chat["name"],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        chat["time"],
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          chat["message"],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      if (chat["unread"] > 0)
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          padding: const EdgeInsets.all(
                                            8,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: Color(
                                              0xff006591,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            chat["unread"].toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            /// EMPTY STATE
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: const Color(0xff006591).withOpacity(.1),
                    child: const Icon(
                      Icons.group_add,
                      size: 35,
                      color: Color(0xff006591),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Planning a new adventure?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Create a group chat to coordinate itineraries, share flight details and plan your journey together.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff006591),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateGroupScreen()));
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      "Start New Trip Chat",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
