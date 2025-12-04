import 'data.dart';

class MovieDetailsResponse {
 const MovieDetailsResponse({
     required this.status,
     required this.statusMessage,
     required this.data,
    });

 factory MovieDetailsResponse.fromJson(dynamic json) {
    return MovieDetailsResponse(
      status: json['status']??'',
      statusMessage: json['status_message']??'',
      data: Data.fromJson(json['data']),
    );
  }
 final String status;
 final String statusMessage;
 final Data data;



}