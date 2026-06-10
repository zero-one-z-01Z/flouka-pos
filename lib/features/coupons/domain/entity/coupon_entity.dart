import '../../../vendor_stores/domain/entity/store_entity.dart';

class CouponEntity {
  final int id;
  final int vendorId;
  final String name;
  final String coupon;
  final num? value;
  final num? min;
  final num? max;
  final String? type;
  final int? count;
  final String? createdAt;
  final List<StoreOption> stores;

  const CouponEntity({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.coupon,
    this.value,
    this.min,
    this.max,
    this.type,
    this.count,
    this.createdAt,
    required this.stores,
  });
}
