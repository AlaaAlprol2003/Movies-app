import '../../../../../../domain/entities/movie_summary_entity.dart';

class WatchListMovie {
  WatchListMovie({
    required  this.movieId,
    required  this.name,
    required  this.rating,
    required  this.imageURL,
    required  this.year,});

 factory WatchListMovie.fromJson(dynamic json) {
    return WatchListMovie(
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

 MovieSummaryEntity toMovieSummaryEntity(){
   return MovieSummaryEntity(
     id: int.parse(movieId),
     rating: rating,
     mediumCoverImage: imageURL,

   );
 }

}