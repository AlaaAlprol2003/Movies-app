import 'watch_list_movie.dart';

class WatchListResponse {
const  WatchListResponse({
    required  this.message,
    required  this.movies,});

 factory WatchListResponse.fromJson(dynamic json) {
    return WatchListResponse(
      message: json['message'],
      movies: json['movies'].map((movie) => WatchListMovie.fromJson(movie)).toList() ,

    );

  }
 final String message;
 final List<WatchListMovie> movies;



}