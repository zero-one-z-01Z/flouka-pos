class UserEntity {
  final int id;
  String? phone;
  String? email;
  String? image;
  String? firstName;
  String? lastName;
  num wallet;
  String? token;

  UserEntity({
    required this.id,
    required this.phone,
    required this.email,
    required this.image,
    required this.firstName,
    required this.lastName,
    required this.wallet,
    this.token,
  });
}
