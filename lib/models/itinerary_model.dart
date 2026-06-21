class Place {
  final String name;
  final double rating;
  final int reviews;
  final String address;
  final String thumbnail;

  Place({
    required this.name,
    required this.rating,
    required this.reviews,
    required this.address,
    required this.thumbnail,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json["name"] ?? "",
      rating: (json["rating"] ?? 0).toDouble(),
      reviews: json["reviews"] ?? 0,
      address: json["address"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
    );
  }
}