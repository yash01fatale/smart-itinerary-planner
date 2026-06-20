import 'package:url_launcher/url_launcher.dart';

class MapsService {
  static Future<void> openLocation(
    String location,
  ) async {
    final Uri url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$location",
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}