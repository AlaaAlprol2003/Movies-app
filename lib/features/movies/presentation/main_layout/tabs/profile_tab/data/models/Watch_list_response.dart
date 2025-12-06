import 'watch_list_movie.dart';

class WatchListResponse {
const  WatchListResponse({
    required  this.message,
    required  this.data,});

 factory WatchListResponse.fromJson(dynamic json) {
    return WatchListResponse(
      message: json['message'],
      data: watch_list_movie.fromJson(json['data']) ,

    );

  }
 final String message;
 final watch_list_movie data;



}