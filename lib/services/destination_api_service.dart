import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/Destination.dart';

class DestinationApiService {
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000/api/destinations';
    }
    return 'http://127.0.0.1:8000/api/destinations';
  }

  static Future<List<Destination>> getDestinations() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List destinations = data['destinations'] ?? [];

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          print(data);
        }

        return destinations
            .map(
              (e) => Destination.fromJson(e),
            )
            .toList();
      }

      throw Exception('Failed to load destinations');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Destination>> getPopularDestinations() async {
    try {
      // For now reuse getDestinations() endpoint and return the list
      final list = await DestinationApiService.getDestinations();
      return list;
    } catch (e) {
      throw Exception('Failed to load popular destinations: $e');
    }
  }
}
