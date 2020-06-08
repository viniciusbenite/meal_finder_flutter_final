class Location {
  Location({this.locality});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locality: json['locality'],
    );
  }

  final String locality;

  Map<String, String> toMap() => {
        'locality': locality ?? 'unknown',
      };
}
