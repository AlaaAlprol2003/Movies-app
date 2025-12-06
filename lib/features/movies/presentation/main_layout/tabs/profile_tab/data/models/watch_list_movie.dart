class watch_list_movie {
  watch_list_movie({
    required  this.movieId,
    required  this.name,
    required  this.rating,
    required  this.imageURL,
    required  this.year,});

 factory watch_list_movie.fromJson(dynamic json) {
    return watch_list_movie(
      movieId: json['movieId'],
      name: json['name'],
      rating: json['rating'],
      imageURL: json['imageURL'],
      year: json['year'],
    );

  }

 final String movieId;
 final String name;
 final double rating;
 final String imageURL;
 final String year;


}