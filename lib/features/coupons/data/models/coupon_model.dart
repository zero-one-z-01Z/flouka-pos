import '../../../vendor_stores/data/models/store_model.dart';
import '../../domain/entity/coupon_entity.dart';

class CouponModel extends CouponEntity {
  const CouponModel({
    required super.id,
    required super.vendorId,
    required super.name,
    required super.coupon,
    super.value,
    super.min,
    super.max,
    super.type,
    super.count,
    super.createdAt,
    required super.stores,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'],
      vendorId: json['vendor_id'],
      name: json['name'],
      coupon: json['coupon'],
      value: json['value'],
      min: json['min'],
      max: json['max'],
      type: json['type'],
      count: json['count'],
      createdAt: json['created_at'],
      stores: (json['stores'] as List?)!.map((e) => StoreOptionModel.fromJson(e)).toList(),
    );
  }

}

