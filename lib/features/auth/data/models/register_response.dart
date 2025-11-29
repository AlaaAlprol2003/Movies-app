import 'package:movies_app/features/auth/data/models/user_data.dart';

class RegisterResponse {
  String message;
  UserData user;

  RegisterResponse({required this.message, required this.user});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json["message"],
      user: UserData.fromJson(json),
    );
  }
}
