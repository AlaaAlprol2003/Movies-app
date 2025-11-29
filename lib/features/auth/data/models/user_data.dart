import 'package:movies_app/features/auth/domain/entities/user_entity.dart';

class UserData {
  String email;
  String password;
  String name;
  String phone;
  int avaterId;
  String sId;
  String createdAt;
  String updatedAt;
  int iV;

  UserData({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.avaterId,
    required this.sId,
    required this.createdAt,
    required this.updatedAt,
    required this.iV,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      phone: json['phone'],
      avaterId: json['avaterId'],
      sId: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
  }


  UserEntity toUserEntity()=> UserEntity(email: email, password: password, name: name, phone: phone, avaterId: avaterId, sId: sId);
}
