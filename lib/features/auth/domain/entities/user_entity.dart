class UserEntity {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? type;
  final String? nationalIdNumber;
  final int? cityId;
  final String? bankAccountNumber;
  final String? frontIdCardImage;
  final String? backIdCardImage;
  final String? token;

  UserEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.type,
    this.nationalIdNumber,
    this.cityId,
    this.bankAccountNumber,
    this.frontIdCardImage,
    this.backIdCardImage,
    this.token,
  });
}