import 'dart:convert';
import 'package:http/http.dart' as http;

class TripService {

  static const baseUrl =
      'http://localhost:5000/api';

  Future<List<dynamic>>
      getUserTrips(
    String uid,
  ) async {

    final response =
        await http.get(
      Uri.parse(
        '$baseUrl/users/$uid/trips',
      ),
    );

    return jsonDecode(response.body);
  }
}