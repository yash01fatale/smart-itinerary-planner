import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_itinerary_planner/models/recommendation_model.dart';

class RecommendationApiService {
  static const String apiUrl =
      'http://10.0.2.2:8000/destinations';

  static Future<List<RecommendationModel>> getTopRecommendations({
    int topN = 10,
  }) async {
    final uri = Uri.parse('$apiUrl?top_n=$topN');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed: ${response.statusCode}');
    }

    final data = jsonDecode(response.body);

    List<dynamic> destinations = data['destinations'] ?? [];

    return destinations
        .map((item) => RecommendationModel.fromJson(item))
        .toList();
  }
}