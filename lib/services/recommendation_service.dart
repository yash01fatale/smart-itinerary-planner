import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recommendation_model.dart';

class RecommendationApiService {
  static const String baseUrl =
      'http://localhost:8000/destinations';

  static Future<List<RecommendationModel>> getTopRecommendations({
    int topN = 10,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?top_n=$topN'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<dynamic> destinations =
            data['destinations'] ?? [];

        return destinations
            .map(
              (item) => RecommendationModel.fromJson(item),
            )
            .toList();
      }

      throw Exception(
        'Failed to load recommendations: ${response.statusCode}',
      );
    } catch (e) {
      throw Exception('Recommendation API Error: $e');
    }
  }
}