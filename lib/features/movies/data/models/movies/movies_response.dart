import 'data.dart';

class MoviesResponse {
 const MoviesResponse({
  required this.status,
  required this.statusMessage,
  required this.data,
  });

 factory MoviesResponse.fromJson(dynamic json) {
   return MoviesResponse(
     status: json['status'],
     statusMessage: json['status_message'],
     data:Data.fromJson(json['data']),
   );

  }

 final String status;
 final String statusMessage;
 final Data data;

}
