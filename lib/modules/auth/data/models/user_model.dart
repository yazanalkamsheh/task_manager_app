import 'package:base_project_v2/modules/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.id,
      required super.username,
      required super.email,
      required super.firstName,
      required super.lastName,
      required super.gender,
      required super.image,
      required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      image: json['image'],
      token: json['accessToken'],
    );
  }
}
