import 'dart:convert';
import 'package:http/http.dart' as http;

class ItineraryApi {
  static const String baseUrl = "http://localhost:8000";

  static Future<dynamic> generateItinerary({
    required String destination,
    required int days,
  }) async {
    final requestBody = {
      "destination": destination,
      "days": days,
    };

    print("========== REQUEST ==========");
    print("$baseUrl/generate-itinerary");
    print(jsonEncode(requestBody));

    final response = await http.post(
      Uri.parse("$baseUrl/generate-itinerary"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
    );

    print("========== RESPONSE ==========");
    print("Status Code: ${response.statusCode}");
    print(response.body);

    return jsonDecode(response.body);
  }
}


// void main() async {
//   print("Starting API Test...");
  
//   try {
//     // 1. Define your custom inputs here
//     String customDestination = "Pune";
//     int customDays = 3;

//     // 2. Call your static API method
//     final result = await ItineraryApi.generateItinerary(
//       destination: customDestination,
//       days: customDays,
//     );

//     print("========== SUCCESS ==========");
//     print("Parsed Result: $result");
    
//   } catch (e) {
//     print("========== ERROR ==========");
//     print("Failed to connect or parse response: $e");
//   }
// }
