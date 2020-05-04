class UserRating {
  final String aggregate_rating;
  final String votes;

  UserRating({this.aggregate_rating, this.votes});

  factory UserRating.fromJson(Map<String, dynamic> json){
    return UserRating(
      aggregate_rating: json['aggregate_rating'],
      votes: json['votes']
    );
  }




}