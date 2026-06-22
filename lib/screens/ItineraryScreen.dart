import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/day_plan.dart';

class ItineraryScreen extends StatefulWidget {
  final List<DayPlan> itinerary;

  const ItineraryScreen({
    super.key,
    required this.itinerary,
  });

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  int _selectedDayIndex = 0;

  // Dynamically safely calculates budget if property is exposed/fetched by data layer
  double? get _calculatedTotalBudget {
    if (widget.itinerary.isEmpty) return null;
    try {
      final currentPlaces = widget.itinerary[_selectedDayIndex].places;
      double total = 0.0;
      bool hasCostData = false;

      for (var place in currentPlaces) {
        // Safe check if your DayPlan model contains dynamic parameters or fallback mapping
        final dynamic costExposed = (place as dynamic).estimatedCost;
        if (costExposed != null) {
          total += (costExposed as num).toDouble();
          hasCostData = true;
        }
      }
      return hasCostData ? total : null;
    } catch (_) {
      return null; // Return null if cost data doesn't exist on your specific model
    }
  }

  Future<void> _openDirections(String address) async {
    final url = Uri.parse(
      "http://maps.google.com/?q=${Uri.encodeComponent(address)}",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itinerary.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No data found")),
      );
    }

    final activeDayPlan = widget.itinerary[_selectedDayIndex];
    final totalBudget = _calculatedTotalBudget;

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC), // Modern slate white
      appBar: AppBar(
        title: const Text(
          "Trip Itinerary",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive layout adapter breakpoint
          if (constraints.maxWidth > 900) {
            return _buildWebView(activeDayPlan, totalBudget);
          }
          return _buildMobileView(activeDayPlan, totalBudget);
        },
      ),
    );
  }

  // ==========================================
  // RESPONSIVE WEB / DESKTOP VIEW
  // ==========================================
  Widget _buildWebView(DayPlan activeDayPlan, double? totalBudget) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Responsive Dynamic Navigation Sidebar
        Container(
          width: 300,
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Timeline Steps",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.itinerary.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == _selectedDayIndex;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        selected: isSelected,
                        selectedTileColor: const Color(0xFFEFF6FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Text(
                          "Day ${widget.itinerary[index].day}",
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? const Color(0xFF2563EB) : const Color(0xFF334155),
                          ),
                        ),
                        onTap: () => setState(() => _selectedDayIndex = index),
                      ),
                    );
                  },
                ),
              ),
              if (totalBudget != null) _buildBudgetCard(totalBudget),
            ],
          ),
        ),
        const VerticalDivider(width: 1, thickness: 1, color: Color(0xFFE2E8F0)),
        // Core Web Feed content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 480,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                mainAxisExtent: 440,
              ),
              itemCount: activeDayPlan.places.length,
              itemBuilder: (context, index) => _buildPlaceCard(activeDayPlan.places[index]),
            ),
          ),
        )
      ],
    );
  }

  // ==========================================
  // RESPONSIVE MOBILE VIEW
  // ==========================================
  Widget _buildMobileView(DayPlan activeDayPlan, double? totalBudget) {
    return Column(
      children: [
        Container(
          height: 54,
          color: Colors.white,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: widget.itinerary.length,
            itemBuilder: (context, index) {
              final isSelected = index == _selectedDayIndex;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  label: Text("Day ${widget.itinerary[index].day}"),
                  selected: isSelected,
                  selectedColor: const Color(0xFF2563EB),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (_) => setState(() => _selectedDayIndex = index),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: activeDayPlan.places.length + (totalBudget != null ? 1 : 0),
            itemBuilder: (context, index) {
              if (totalBudget != null && index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildBudgetCard(totalBudget),
                );
              }
              final actualPlaceIndex = totalBudget != null ? index - 1 : index;
              return _buildPlaceCard(activeDayPlan.places[actualPlaceIndex]);
            },
          ),
        ),
      ],
    );
  }

  // ==========================================
  // SHARED MODULAR COMPONENTS
  // ==========================================
  
  // Premium Modern Budget Summary Component Card
  Widget _buildBudgetCard(double totalBudget) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF0F172A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Estimated Route Expenses",
            style: TextStyle(color: Color(0xFF93C5FD), fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            "\$${totalBudget.toStringAsFixed(2)}",
            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceCard(dynamic place) {
    double? itemCost;
    try {
      itemCost = (place as dynamic).estimatedCost?.toDouble();
    } catch (_) {}

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              if (place.thumbnail.isNotEmpty)
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    place.thumbnail,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                  ),
                )
              else
                _buildPlaceholder(),
                
              if (itemCost != null)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "\$${itemCost.toStringAsFixed(0)}",
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.redAccent),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        place.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Color(0xFF64748B)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "⭐ ${place.rating} (${place.reviews} reviews)",
                  style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                ),
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  icon: const Icon(Icons.navigation, size: 16, color: Colors.white),
                  label: const Text("Navigate", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    minimumSize: const Size(double.infinity, 40),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => _openDirections(place.address),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF1F5F9),
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: const Icon(Icons.photo_outlined, size: 40, color: Color(0xFF94A3B8)),
    );
  }
}