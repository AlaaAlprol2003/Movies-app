class RegisterRequest {
  String name;
  String email;
  String password;
  String confirmPassword;
  String phone;
  int avaterId;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.avaterId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    data['phone'] = phone;
    data['avaterId'] = avaterId;
    return data;
  }
}
