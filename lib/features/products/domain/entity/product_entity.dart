import 'package:equatable/equatable.dart';

import '../../../categories/domain/entity/brand_entity.dart';
import '../../../categories/domain/entity/category_entity.dart';
import 'attribute_entity.dart';
import 'product_review_entity.dart';
import 'variant_entity.dart';

class ProductEntity {
  final int id;
  final String? title;
  final String? description;
  final String? discountTitle;
  final num? price;
  final num? costPrice;
  final num? offerPrice;
  final num? discountPercentage;
  final num? orderCount;
  final String? sku;
  final List<ProductImage>? images;
  final List<TagEntity>? tags;
  final CategoryEntity? category;
  final BrandEntity? brand;
  final List<VariantEntity> variants;
  final String? image;
  final num? avgRating;
  QuantityEntity? stock;

  ProductEntity({
    required this.id,
    required this.title,
    required this.costPrice,
    required this.description,
    required this.stock,
     this.discountTitle,
    required this.price,
    required this.offerPrice,
    required this.image,
    this.discountPercentage,
    required this.images,
    this.avgRating,
    required this.variants, this.orderCount, this.sku, this.tags, this.category, this.brand,
  });
}
class ProductImage {
  final String image;
  final int id;
  const ProductImage({required this.image,required this.id});
}

class ProductOptionEntity extends Equatable{
  final int id;
  final String title;
  ProductOptionEntity({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];
}
class TagEntity extends Equatable{
  final int id;
  final String name;
  final DateTime time;
  TagEntity({
    required this.id,
    required this.time,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name,time];
}

class QuantityEntity extends Equatable{
  final int id;
  final int storeProductID;
  final int? productVariantID;
  final int quantity;
  QuantityEntity({
    required this.id,
    required this.storeProductID,
    required this.productVariantID,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, storeProductID, productVariantID, quantity];
}
