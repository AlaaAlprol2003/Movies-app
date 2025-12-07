import 'watch_list_movie.dart';

class WatchListResponse {
  WatchListResponse({
     required this.message,
     required this.movies,});

 factory WatchListResponse.fromJson(dynamic json) {
    return WatchListResponse(
      message: json['message'],
      movies: (json['data'] as List).map((i) => WatchListMovie.fromJson(i)).toList(),
    );

  }
 final String message;
 final List<WatchListMovie> movies;


}