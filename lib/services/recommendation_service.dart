import 'dart:convert';
import 'package:http/http.dart' as http;

class RecommendationService {

  static const baseUrl =
      'http://localhost:5000/api';

  Future<List<dynamic>>
      getRecommendations({
    required int travelers,
    required int days,
    required int budget,
    required String category,
  }) async {

    final response =
        await http.post(
      Uri.parse(
          '$baseUrl/recommendations'),
      headers: {
        'Content-Type':
            'application/json',
      },
      body: jsonEncode({
        'travelers': travelers,
        'days': days,
        'budget': budget,
        'category': category,
      }),
    );

    return jsonDecode(response.body);
  }
}