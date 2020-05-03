class Location{
  final String locality;

  Location({this.locality});

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      locality: json['locality'],
    );
  }
}