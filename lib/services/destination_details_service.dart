import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/destination_details_model.dart';

class DestinationDetailsService {

static const String baseUrl =
'http://localhost:8000';

Future<DestinationDetailsModel>
getDetails(String city) async {

final response = await http.get(
  Uri.parse(
    '$baseUrl/destination/$city',
  ),
);

final data =
    jsonDecode(response.body);

return DestinationDetailsModel
    .fromJson(data);
}
}
