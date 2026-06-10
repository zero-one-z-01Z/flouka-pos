import '../../../products/domain/entity/product_entity.dart';
import '../../../vendor_stores/domain/entity/store_entity.dart';

class PopularCategoryEntity {
  final int id;
  final String image;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final List<int> productsIds;

  const PopularCategoryEntity({
    required this.id,
    required this.productsIds,
    required this.image,
    required this.name,
    required this.startDate,
    required this.endDate,
  });
}
