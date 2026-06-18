import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recommendation_model.dart';

class RecommendationApiService {

  static const String baseUrl =
      'http://192.168.29.170:8000';

  Future<List<RecommendationModel>>
      getPopularDestinations() async {

    final response = await http.get(
      Uri.parse(
        '$baseUrl/popular-destinations',
      ),
    );

    if (response.statusCode == 200) {

      final data =
          jsonDecode(response.body);

      final List destinations =
          data['destinations'];

      return destinations
          .map(
            (e) =>
                RecommendationModel
                    .fromJson(e),
          )
          .toList();
    }

    return [];
  }
}