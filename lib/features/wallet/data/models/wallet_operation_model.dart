import 'package:flouka_pos/core/helper_function/convert.dart';

import '../../domain/entity/wallet_operation_entity.dart';

class WalletOperationModel extends WalletOperationEntity {
  const WalletOperationModel({
    required super.id,
    required super.amount,
    required super.operation,
    super.vendorId,
    required super.createdAt,
  });

  factory WalletOperationModel.fromJson(Map<String, dynamic> json) {
    return WalletOperationModel(
      id: json['id'],
      amount: convertDataToNum(json['amount']) ?? 0,
      operation: WalletOperationType.fromRaw(json['operation']),
      vendorId: json['vendor_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
