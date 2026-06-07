import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/app_routes.dart';

class TripInputScreen extends StatefulWidget {
  const TripInputScreen({super.key});

  @override
  State<TripInputScreen> createState() => _TripInputScreenState();
}

class _TripInputScreenState extends State<TripInputScreen> {
  final TextEditingController destinationController = TextEditingController();

  final TextEditingController travelerController = TextEditingController();

  String selectedCategory = "Beach";

  DateTime? startDate;
  DateTime? endDate;

  double budget = 25000;

  final List<String> categories = [
    "Beach",
    "Hill Station",
    "Mountains",
    "Historical",
    "Adventure",
    "Wildlife",
    "Religious",
  ];

  Future<void> pickStartDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> pickEndDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: startDate ?? DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        title: const Text("Plan Your Journey"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: destinationController,
              decoration: InputDecoration(
                labelText: "Destination",
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              value: selectedCategory,
              decoration: InputDecoration(
                labelText: "Category",
                prefixIcon: const Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: pickStartDate,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.calendar_month),
                          const SizedBox(height: 8),
                          Text(
                            startDate == null
                                ? "Start Date"
                                : DateFormat('dd MMM yyyy').format(startDate!),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: InkWell(
                    onTap: pickEndDate,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.event),
                          const SizedBox(height: 8),
                          Text(
                            endDate == null
                                ? "End Date"
                                : DateFormat('dd MMM yyyy').format(endDate!),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: travelerController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Travelers",
                prefixIcon: const Icon(Icons.groups),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Budget",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "₹${budget.toInt()}",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Slider(
              value: budget,
              min: 2000,
              max: 100000,
              divisions: 98,
              label: budget.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  budget = value;
                });
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.smart_toy),
                label: const Text(
                  "Generate Itinerary",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFBBF24),
                ),
                onPressed: () {
                  print({
                    "destination": destinationController.text,
                    "category": selectedCategory,
                    "startDate": startDate.toString(),
                    "endDate": endDate.toString(),
                    "travelers": travelerController.text,
                    "budget": budget.toInt(),
                  });

                  Navigator.pushNamed(context, AppRoutes.itinerary);
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
