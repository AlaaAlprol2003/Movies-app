class EditProfileResponse {
  final String message;

  const EditProfileResponse({required this.message});

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) {
    return EditProfileResponse(message: json["message"]);
  }
}
