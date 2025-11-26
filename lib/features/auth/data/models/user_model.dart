import 'dart:developer';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.phone,
    required super.email,
    super.token,
    required super.image,
    required super.firstName,
    required super.lastName,
    required super.wallet,
  });

  factory UserModel.fromJson(Map data) {
    try {
      return UserModel(
        id: data['id'],
        phone: data['phone'],
        email: data['email'],
        token: data['token'],
        image: data['image'],
        firstName: data['first_name'],
        lastName: data['last_name'],
        wallet: data['wallet'],
      );
    } catch (e, line) {
      log(line.toString());
      log(e.toString());
      throw Exception(e);
    }
  }
}
