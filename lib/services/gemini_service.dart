// lib/services/gemini_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_constants.dart';
import '../models/all_models.dart';

class GeminiService {
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

  Future<ItineraryModel> generateItinerary(TripModel trip) async {
    final prompt = _buildPrompt(trip);

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl?key=${AppConstants.geminiApiKey}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [{'parts': [{'text': prompt}]}],
          'generationConfig': {'temperature': 0.7, 'maxOutputTokens': 4096},
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates'][0]['content']['parts'][0]['text'] as String;
        return _parseItinerary(text, trip);
      } else {
        throw Exception('Gemini API error: ${response.statusCode}');
      }
    } catch (e) {
      // Return mock itinerary on error for development
      return _generateMockItinerary(trip);
    }
  }

  String _buildPrompt(TripModel trip) {
    return '''
You are an expert Indian travel planner. Generate a detailed ${trip.days}-day itinerary for ${trip.destinationName}.

Trip Details:
- Destination: ${trip.destinationName}
- Duration: ${trip.days} days
- Travelers: ${trip.adults} adults, ${trip.children} children
- Budget: ${trip.budgetTier}
- Interests: ${trip.interests.join(', ')}

Return ONLY a valid JSON object with this exact structure:
{
  "dayPlans": [
    {
      "dayNumber": 1,
      "theme": "Arrival & Exploration",
      "spots": [
        {
          "id": "spot_1",
          "name": "Place Name",
          "description": "Brief description (2-3 sentences with historical/cultural info)",
          "category": "Temple/Fort/Museum/Nature/etc",
          "latitude": 32.2396,
          "longitude": 77.1887,
          "rating": 4.5,
          "suggestedDuration": "2 hours",
          "distanceFromPrev": 3.2,
          "timeSlot": "9:00 AM",
          "entryFee": 50,
          "tags": ["heritage", "photography"]
        }
      ],
      "meals": [
        {
          "type": "lunch",
          "restaurantName": "Restaurant Name",
          "cuisine": "Local/Indian/etc",
          "estimatedCost": 400
        }
      ],
      "totalDistance": 15.5,
      "estimatedCost": 2500,
      "note": "Optional tip for the day"
    }
  ],
  "budget": {
    "transportation": 5000,
    "accommodation": 8000,
    "food": 3000,
    "entryFees": 1000,
    "shopping": 2000,
    "miscellaneous": 1000
  },
  "weatherSummary": "Brief weather description for best travel months",
  "generalTips": "3-4 important travel tips for this destination",
  "packingList": ["item1", "item2", "item3", "item4", "item5"]
}

Include ${trip.days} complete days. Make spots realistic for ${trip.destinationName}. Costs in INR.
''';
  }

  ItineraryModel _parseItinerary(String jsonText, TripModel trip) {
    try {
      // Clean JSON from markdown code blocks if present
      String cleaned = jsonText.trim();
      if (cleaned.startsWith('```json')) cleaned = cleaned.substring(7);
      if (cleaned.startsWith('```')) cleaned = cleaned.substring(3);
      if (cleaned.endsWith('```')) cleaned = cleaned.substring(0, cleaned.length - 3);
      cleaned = cleaned.trim();

      final data = jsonDecode(cleaned) as Map<String, dynamic>;
      return ItineraryModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        trip: trip,
        dayPlans: (data['dayPlans'] as List).map((d) => DayPlanModel.fromMap(d)).toList(),
        budget: BudgetBreakdown.fromMap(data['budget'] ?? {}),
        weatherSummary: data['weatherSummary'] ?? '',
        generalTips: data['generalTips'] ?? '',
        packingList: List<String>.from(data['packingList'] ?? []),
        generatedAt: DateTime.now(),
      );
    } catch (e) {
      return _generateMockItinerary(trip);
    }
  }

  ItineraryModel _generateMockItinerary(TripModel trip) {
    final days = List.generate(trip.days, (i) => DayPlanModel(
      dayNumber: i + 1,
      theme: _dayThemes[i % _dayThemes.length],
      spots: _getSampleSpots(trip.destinationName, i),
      meals: _getSampleMeals(i),
      totalDistance: 12.0 + (i * 3),
      estimatedCost: 2000.0 + (i * 500),
      note: _dayNotes[i % _dayNotes.length],
    ));

    return ItineraryModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      trip: trip,
      dayPlans: days,
      budget: BudgetBreakdown(
        transportation: 4000, accommodation: 6000, food: 3000,
        entryFees: 800, shopping: 2000, miscellaneous: 1200,
      ),
      weatherSummary: 'Pleasant weather expected. Carry light woolens for evenings.',
      generalTips: 'Carry cash as many local shops don\'t accept cards. Hire a local guide for hidden gems. Try local street food for authentic experience.',
      packingList: ['Comfortable walking shoes', 'Sunscreen', 'Light jacket', 'Water bottle', 'Power bank', 'First aid kit', 'Camera', 'Sunglasses'],
      generatedAt: DateTime.now(),
    );
  }

  final _dayThemes = ['Arrival & Exploration', 'Heritage & Culture', 'Nature & Adventure', 'Local Life', 'Leisure & Departure'];
  final _dayNotes = ['Start early to avoid crowds', 'Wear comfortable shoes', 'Carry cash for local markets', 'Try the local street food', 'Book tickets in advance'];

  List<SpotModel> _getSampleSpots(String destination, int dayIndex) {
    final spotsByDay = [
      [
        SpotModel(id: 's1', name: 'Main Temple', description: 'Ancient temple with stunning architecture and spiritual significance. A must-visit landmark of the region.', category: 'Temple', latitude: 32.23, longitude: 77.18, suggestedDuration: '2 hours', timeSlot: '9:00 AM', rating: 4.7, distanceFromPrev: 0, entryFee: 0, tags: ['heritage', 'spiritual']),
        SpotModel(id: 's2', name: 'Valley Viewpoint', description: 'Breathtaking panoramic views of the entire valley and surrounding mountains. Perfect for photography.', category: 'Nature', latitude: 32.25, longitude: 77.19, suggestedDuration: '1.5 hours', timeSlot: '12:00 PM', rating: 4.5, distanceFromPrev: 4.2, entryFee: 0, tags: ['photography', 'nature']),
        SpotModel(id: 's3', name: 'Local Market', description: 'Vibrant local bazaar selling handicrafts, spices, and fresh produce. Immerse in local culture.', category: 'Market', latitude: 32.22, longitude: 77.17, suggestedDuration: '2 hours', timeSlot: '3:00 PM', rating: 4.3, distanceFromPrev: 3.1, entryFee: 0, tags: ['shopping', 'culture']),
      ],
      [
        SpotModel(id: 's4', name: 'Ancient Fort', description: 'Historic fort offering insights into the region\'s glorious past with panoramic views from the ramparts.', category: 'Fort', latitude: 32.24, longitude: 77.20, suggestedDuration: '3 hours', timeSlot: '9:00 AM', rating: 4.6, distanceFromPrev: 0, entryFee: 100, tags: ['heritage', 'history']),
        SpotModel(id: 's5', name: 'Museum', description: 'Regional museum showcasing artifacts, paintings, and exhibits from different historical eras.', category: 'Museum', latitude: 32.23, longitude: 77.18, suggestedDuration: '1.5 hours', timeSlot: '1:00 PM', rating: 4.2, distanceFromPrev: 2.5, entryFee: 50, tags: ['history', 'culture']),
        SpotModel(id: 's6', name: 'Sunset Point', description: 'Famous vantage point offering spectacular sunset views over the landscape. Magical golden hour experience.', category: 'Viewpoint', latitude: 32.26, longitude: 77.21, suggestedDuration: '1 hour', timeSlot: '5:30 PM', rating: 4.8, distanceFromPrev: 5.0, entryFee: 0, tags: ['photography', 'nature']),
      ],
      [
        SpotModel(id: 's7', name: 'Adventure Sports Zone', description: 'Thrilling outdoor activities including trekking, rappelling, and zip-lining amidst scenic landscapes.', category: 'Adventure', latitude: 32.28, longitude: 77.22, suggestedDuration: '4 hours', timeSlot: '8:00 AM', rating: 4.7, distanceFromPrev: 0, entryFee: 500, tags: ['adventure', 'nature']),
        SpotModel(id: 's8', name: 'River Side', description: 'Serene riverside spot perfect for relaxation and photography. Popular for nature walks and picnics.', category: 'Nature', latitude: 32.22, longitude: 77.16, suggestedDuration: '1.5 hours', timeSlot: '4:00 PM', rating: 4.4, distanceFromPrev: 8.0, entryFee: 0, tags: ['nature', 'relaxation']),
      ],
    ];
    return spotsByDay[dayIndex % spotsByDay.length];
  }

  List<MealSuggestion> _getSampleMeals(int dayIndex) => [
    MealSuggestion(type: 'breakfast', restaurantName: 'Local Dhaba', cuisine: 'Indian', estimatedCost: 200),
    MealSuggestion(type: 'lunch', restaurantName: 'Mountain View Restaurant', cuisine: 'Regional Cuisine', estimatedCost: 400),
    MealSuggestion(type: 'dinner', restaurantName: 'Riverside Café', cuisine: 'Multi-cuisine', estimatedCost: 600),
  ];
}