import 'user.dart';

class ProfileResponse {
  ProfileResponse({
    required  this.message,
    required  this.data,});

 factory ProfileResponse.fromJson(dynamic json) {
    return ProfileResponse(
      message: json['message'],
      data: user.fromJson(json['data']),
    );
  }
 final String message;
 final user data;

}