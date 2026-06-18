import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/recommendation_model.dart';

class RecommendationApiService {

  // Replace with your PC IPv4 Address
  static const String baseUrl =
      'http://192.168.29.170:8000';

  Future<List<RecommendationModel>>
      getPopularDestinations() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/popular-destinations',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(response.body);

        if (data['success'] == true) {
          final List<dynamic> destinations =
              data['destinations'] ?? [];

          return destinations
              .map(
                (item) =>
                    RecommendationModel
                        .fromJson(item),
              )
              .toList();
        }

        return [];
      }

      throw Exception(
        'Server Error: ${response.statusCode}',
      );
    } catch (e) {
      print(
        'Popular Destinations Error: $e',
      );
      return [];
    }
  }

  Future<List<RecommendationModel>>
      getTopRecommendations({
    int topN = 10,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/destinations?top_n=$topN',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(response.body);

        final List<dynamic> destinations =
            data['destinations'] ?? [];

        return destinations
            .map(
              (item) =>
                  RecommendationModel
                      .fromJson(item),
            )
            .toList();
      }

      throw Exception(
        'Failed to load recommendations',
      );
    } catch (e) {
      print(
        'Recommendation Error: $e',
      );
      return [];
    }
  }
}