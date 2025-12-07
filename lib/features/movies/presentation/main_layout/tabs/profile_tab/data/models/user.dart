import 'package:movies_app/features/auth/domain/entities/user_entity.dart';

import '../../domain/entities/user_profile_entity.dart';

class user {
  user({
     required this.id,
     required this.email,
     required this.password,
     required this.name,
     required this.phone,
     required this.avaterId,
     required this.createdAt,
     required this.updatedAt,
     required this.v,});

 factory user.fromJson(dynamic json) {
    return user(
      id: json['_id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      phone: json['phone'],
      avaterId: json['avaterId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
 final String id;
 final String email;
 final String password;
 final String name;
 final String phone;
 final int avaterId;
 final String createdAt;
 final String updatedAt;
 final int v;

  UserProfileEntity toUserProfileEntity(){
  return UserProfileEntity(
    name: name,
    phone: phone,
    avaterId: avaterId,
    email: email,
  );
}

}