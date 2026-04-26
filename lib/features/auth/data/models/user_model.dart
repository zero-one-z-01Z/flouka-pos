import 'package:flouka_pos/core/helper_function/convert.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required int id,
    required double lat,
    required double lng,
    required String phone,
    required String token,
  }) : super(id: id, lat: lat, lng: lng, phone: phone, token: token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      lat: convertDataToDouble(json['lat']),
      lng: convertDataToDouble(json['lng']),
      phone: json['phone'],
      token: json['token'],
    );
  }
}
