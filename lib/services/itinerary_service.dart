import 'dart:convert';
import 'package:http/http.dart' as http;

class ItineraryService {

  static const baseUrl =
      'http://localhost:5000/api';

  Future<Map<String, dynamic>>
      generatePlan({
    required String userId,
    required int travelers,
    required int days,
    required int budget,
    required String category,
  }) async {

    final response =
        await http.post(
      Uri.parse(
          '$baseUrl/itinerary/generate'),
      headers: {
        'Content-Type':
            'application/json',
      },
      body: jsonEncode({
        'userId': userId,
        'travelers': travelers,
        'days': days,
        'budget': budget,
        'category': category,
      }),
    );

    return jsonDecode(response.body);
  }
}