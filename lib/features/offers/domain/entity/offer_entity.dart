import '../../../products/domain/entity/product_entity.dart';
import '../../../vendor_stores/domain/entity/store_entity.dart';

class OfferEntity {
  final int id;
  final int vendorId;
  final String name;
  final num percentage;
  final DateTime createdAt;
  final List<ProductOptionEntity> products;

  const OfferEntity({
    required this.id,
    required this.vendorId,
    required this.name,
    required this.products,
    required this.percentage,
    required this.createdAt,
  });
}
