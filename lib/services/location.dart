class Location {
  double lat;
  double long;
  String? description;

  Location({required this.lat, required this.long, this.description});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json['lat'] as double,
        long: json['long'] as double,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'long': long,
        'description': description,
      };
}
