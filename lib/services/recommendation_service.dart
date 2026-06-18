import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recommendation_model.dart';

class RecommendationApiService {
  static const String baseUrl = 'http://localhost:8000';

  Future<List<RecommendationModel>> getPopularDestinations() async {
    final response = await http.get(
      Uri.parse('$baseUrl/popular-destinations'),
    );


    print("STATUS CODE: ${response.statusCode}");
    print("BODY: ${response.body}");
    
    if (response.statusCode == 200) {
  final data = jsonDecode(response.body);

  print("API DATA:");
  print(data);

  final List<dynamic> destinations =
      data['destinations'] ?? [];

  print(
      "DESTINATION COUNT = ${destinations.length}");

  return destinations
      .map(
        (e) => RecommendationModel.fromJson(e),
      )
      .toList();
}
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<dynamic> destinations = data['destinations'] ?? [];

      return destinations
          .map(
            (e) => RecommendationModel.fromJson(e),
          )
          .toList();
    }

    throw Exception(
      'Failed to load destinations',
    );
  }
}
