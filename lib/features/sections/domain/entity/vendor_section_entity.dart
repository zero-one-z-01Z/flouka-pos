import '../../../products/domain/entity/product_entity.dart';
import '../../../vendor_stores/domain/entity/store_entity.dart';

class VendorSectionEntity {
  final int id;
  final String title;
  final List<int> productsIds;

  const VendorSectionEntity({
    required this.id,
    required this.productsIds,
    required this.title,
  });
}
