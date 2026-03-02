import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    int? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? type,
    String? nationalIdNumber,
    int? cityId,
    String? bankAccountNumber,
    String? frontIdCardImage,
    String? backIdCardImage,
    String? token,
  }) : super(
         id: id,
         firstName: firstName,
         lastName: lastName,
         phone: phone,
         email: email,
         type: type,
         nationalIdNumber: nationalIdNumber,
         cityId: cityId,
         bankAccountNumber: bankAccountNumber,
         frontIdCardImage: frontIdCardImage,
         backIdCardImage: backIdCardImage,
         token: token,
       );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      email: json['email'],
      type: json['type'],
      nationalIdNumber: json['national_id_number'],
      cityId: json['city_id'],
      bankAccountNumber: json['bank_account_number'],
      frontIdCardImage: json['front_id_card_image'],
      backIdCardImage: json['back_id_card_image'],
      token: json['token'],
    );
  }
}
