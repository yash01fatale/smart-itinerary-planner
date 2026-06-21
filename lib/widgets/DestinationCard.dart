import 'package:flutter/material.dart';
import '../models/Destination.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onSave;

  const DestinationCard({
    super.key,
    required this.destination,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            destination.thumbnail,
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(destination.country),

                const SizedBox(height: 12),

                Text("${destination.startDate} → ${destination.endDate}"),

                const SizedBox(height: 8),

                Text("\$${destination.hotelPrice}/night"),

                const SizedBox(height: 8),

                // Text("${destination.carDuration ?? 0} min"),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSave,
                    child: const Text("Save Trip"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}