class WithdrawEntity {
  final int id;
  final int vendorId;
  final String? paypal;
  final String? iban;
  final String name;
  final num amount;
  final String? image;
  final String status;
  final DateTime createdAt;

  const WithdrawEntity({
    required this.id,
    required this.vendorId,
    this.paypal,
    this.iban,
    required this.name,
    required this.amount,
    this.image,
    required this.status,
    required this.createdAt,
  });
}
