import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController groupController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  int selectedCount = 1;

  final List<Map<String, dynamic>> contacts = [
    {
      "name": "Sarah Jenkins",
      "email": "sarah.j@travel.com",
      "image":
          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400",
      "selected": false,
    },
    {
      "name": "Marcus Thorne",
      "email": "marcus.t@world.org",
      "image":
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400",
      "selected": false,
    },
    {
      "name": "David Chen",
      "email": "d.chen@itinerary.io",
      "image":
          "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400",
      "selected": true,
    },
    {
      "name": "Elena Rodriguez",
      "email": "elena.r@globetrotter.com",
      "image":
          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400",
      "selected": false,
    },
  ];

  void updateCount() {
    selectedCount =
        contacts.where((element) => element["selected"] == true).length;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FF),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Create Group",
          style: TextStyle(
            color: Color(0xff006591),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xff006591)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400",
              ),
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            /// HEADER
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Create Travel Group",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Gather your friends and start planning your next adventure together.",
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// GROUP DETAILS
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(.08),
                    blurRadius: 20,
                  )
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: groupController,
                    decoration: InputDecoration(
                      labelText: "Group Name",
                      prefixIcon: const Icon(Icons.groups),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Trip Destination",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Paris",
                        child: Text("Paris Getaway - June 15"),
                      ),
                      DropdownMenuItem(
                        value: "Tokyo",
                        child: Text("Tokyo Explorer - Oct 12"),
                      ),
                      DropdownMenuItem(
                        value: "Bali",
                        child: Text("Bali Retreat - Dec 05"),
                      ),
                    ],
                    onChanged: (v) {},
                  ),

                  const SizedBox(height: 12),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle),
                      label: const Text("Create New Itinerary"),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// FRIENDS CARD
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search friends",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: const Color(0xffEFF4FF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  ListView.builder(
                    itemCount: contacts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final user = contacts[index];

                      return CheckboxListTile(
                        value: user["selected"],
                        onChanged: (value) {
                          user["selected"] = value;
                          updateCount();
                        },
                        secondary: CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              NetworkImage(user["image"]),
                        ),
                        title: Text(
                          user["name"],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(user["email"]),
                      );
                    },
                  ),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xffE5EEFF),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(24),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$selectedCount Members Selected",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff006591),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            for (var c in contacts) {
                              c["selected"] = true;
                            }
                            updateCount();
                          },
                          child: const Text("Select All"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// BUTTONS
            Row(
              children: [

                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(0, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Save Draft"),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Create Group"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFBBF24),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(0, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}