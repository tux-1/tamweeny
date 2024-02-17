class Location {
  final int id;
  final double lat;
  final double long;

  Location({
    required this.id,
    required this.lat,
    required this.long,
  });

  factory Location.fromJson(List<dynamic> json) {
    return Location(
      id: json[0],
      lat: double.parse(json[1]),
      long: double.parse(json[2]),
    );
  }
}
