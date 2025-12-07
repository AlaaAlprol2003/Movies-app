class WatchListRequest {
 const WatchListRequest({
     required this.movieId,
     required this.name,
     required this.rating,
     required this.imageURL,
     required this.year,});

 final String movieId;
 final String name;
 final double rating;
 final String imageURL;
 final String year;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movieId'] = movieId;
    map['name'] = name;
    map['rating'] = rating;
    map['imageURL'] = imageURL;
    map['year'] = year;
    return map;
  }

}