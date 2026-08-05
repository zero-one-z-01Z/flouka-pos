import 'package:flouka_pos/core/helper_function/convert.dart';

import '../../domain/entity/withdraw_entity.dart';

class WithdrawModel extends WithdrawEntity {
  const WithdrawModel({
    required super.id,
    required super.vendorId,
    super.paypal,
    super.iban,
    required super.name,
    required super.amount,
    super.image,
    required super.status,
    required super.createdAt,
  });

  factory WithdrawModel.fromJson(Map<String, dynamic> json) {
    return WithdrawModel(
      id: json['id'],
      vendorId: json['vendor_id'],
      paypal: json['paypal'],
      iban: json['iban'],
      name: json['name'],
      amount: convertDataToNum(json['amount']) ?? 0,
      image: json['image'],
      status: json['status'] ?? 'pending',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
