import 'movie.dart';

class Data {
  Data({
     required this.movieCount,
     required this.limit,
     required this.pageNumber,
     required this.movies,});

 factory Data.fromJson(dynamic json) {
   return Data(
     movieCount: json['movie_count'],
     limit: json['limit'],
     pageNumber: json['page_number'],
     movies: (json['movies'] as List).map((i) => Movie.fromJson(i)).toList(),

   );

  }
 final int movieCount;
 final int limit;
 final int pageNumber;
 final List<Movie> movies;


}