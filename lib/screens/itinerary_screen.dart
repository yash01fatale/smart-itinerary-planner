import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../data/itinerary_places.dart';

class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({super.key});
  Future<void> openFlights(
    String destination,
  ) async {
    final Uri url = Uri.parse(
      "https://www.google.com/travel/flights",
    );

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> openHotels(
    String place,
  ) async {
    final Uri url = Uri.parse(
      "https://www.google.com/maps/search/hotels+near+$place",
    );

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    final tripData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final destination = tripData?["destination"] ?? "Goa";

    final days = tripData?["days"] ?? 3;

    final budget = tripData?["budget"] ?? 25000;

    final travelers = tripData?["travelers"] ?? 2;
    final image = tripData?["image"] ?? "";

    final itinerary = [
      allPlaces.sublist(0, 5),
      allPlaces.sublist(5, 10),
      allPlaces.sublist(10, 15),
    ];
    return DefaultTabController(
      length: days,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "$destination Itinerary",
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          destination,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: image.isNotEmpty
                        ? Container(
                            height: 120,
                            width: double.infinity,
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            height: 120,
                            width: double.infinity,
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.image,
                                size: 60,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$days Days",
                      ),
                      Text(
                        "$travelers Travelers",
                      ),
                      Text(
                        "₹$budget",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TabBar(
              isScrollable: true,
              tabs: List.generate(
                days,
                (index) => Tab(
                  text: "Day ${index + 1}",
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: List.generate(
                  days,
                  (dayIndex) {
                    final places = itinerary[dayIndex % itinerary.length];

                    return ListView.builder(
                      padding: const EdgeInsets.all(
                        15,
                      ),
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        final place = places[index] as Map<String, dynamic>;

                        return Container(
                          height: 180,
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // IMAGE
                              ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                  left: Radius.circular(20),
                                ),
                                child: Image.network(
                                  place["image"] ?? "",
                                  width: 140,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (
                                    context,
                                    error,
                                    stackTrace,
                                  ) {
                                    return Container(
                                      width: 140,
                                      color: Colors.grey.shade300,
                                      child: const Center(
                                        child: Icon(
                                          Icons.image,
                                          size: 40,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        place["name"] ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 5),

                                      Text(
                                        place["description"] ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.orange,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            place["rating"] ?? "4.5",
                                          ),
                                          const SizedBox(width: 15),
                                          const Icon(
                                            Icons.route,
                                            size: 16,
                                            color: Colors.green,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            place["distance"] ?? "5 km",
                                          ),
                                        ],
                                      ),

                                      const Spacer(),

                                      // ACTION BUTTONS
                                      Wrap(
                                        spacing: 6,
                                        runSpacing: 6,
                                        children: [
                                          ElevatedButton.icon(
                                            icon: const Icon(
                                              Icons.visibility,
                                              size: 16,
                                            ),
                                            label: const Text("View"),
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  '/destination_details',
                                                  arguments: place["name"]
                                                  );
                                            },
                                          ),
                                          ElevatedButton.icon(
                                            icon: const Icon(
                                              Icons.map,
                                              size: 16,
                                            ),
                                            label: const Text("Map"),
                                            onPressed: () {
                                              openFlights(
                                                place["name"],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // RIGHT SIDE ACTIONS
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      tooltip: "Hotels",
                                      icon: const Icon(
                                        Icons.hotel,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        openHotels(
                                          place["name"],
                                        );
                                      },
                                    ),
                                    IconButton(
                                      tooltip: "Flights",
                                      icon: const Icon(
                                        Icons.flight,
                                        color: Colors.orange,
                                      ),
                                      onPressed: () {
                                        openFlights(
                                          place["name"],
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.share),
                                      onPressed: () {
                                        Share.share(
                                          '''
${place["name"]}

${place["description"]}

Explore with TravelWise AI
      ''',
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isFavorite = !isFavorite;
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              isFavorite
                                                  ? "Added to Favorites"
                                                  : "Removed from Favorites",
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
