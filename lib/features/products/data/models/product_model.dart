import 'dart:developer';
import '../../../../core/helper_function/convert.dart';
import '../../../categories/data/model/brand_model.dart';
import '../../../categories/data/model/category_model.dart';
import '../../domain/entity/product_entity.dart';
import 'attribute_model.dart';
import 'product_review_model.dart';
import 'variant_model.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    super.title,
    super.description,
    required super.image,
    super.price,
    super.offerPrice,
    required super.images,
    super.avgRating,
    super.sku,
    super.orderCount,
    super.tags,
    super.category,
    super.stock,
    super.brand,
    required super.discountTitle,
    required super.discountPercentage, required super.variants, required super.costPrice,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<ProductImageModel> images=[];
    List<VariantModel> variants =[];

    if(json['images'] !=null){
      for(var element in json['images']){
        images.add(ProductImageModel.fromJson(element));
      }
    }
    if(json['variants'] !=null){
      for(var element in json['variants']){
        variants.add(VariantModel.fromJson(element));
      }
    }

    try {
      return ProductModel(
        id: json['id'],
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        image: json['image'] ,
        price: convertDataToNum(json['price']),
        offerPrice: convertDataToNum(json['offer_price']),
        images: images,
        avgRating: json['avg_rating'] != null
            ? convertDataToNum(json['avg_rating'])
            : null,
        costPrice: json['cost_price'] != null ? convertDataToNum(json['cost_price']) : null,
        sku: json['sku'] ?? "",
        orderCount: json['order_count'] != null ? convertDataToNum(json['order_count']) : null,
        tags: json['tags'] != null ? (json['tags'] as List).map((e) => TagModel.fromJson(e)).toList() : null,
        category: json['category'] != null ? CategoryModel.fromJson(json['category']) : null,
        brand: json['brand'] != null ? BrandModel.fromJson(json['brand']) : null,
        discountTitle: json['discount_title'] ?? "",
        discountPercentage: convertDataToNum(json['discount_percentage']) ?? 0,
        stock: json['stock'] != null ? QuantityModel.fromJson(json['stock']) : null,
        variants: variants,
      );
    } catch (e, l) {
      log(l.toString());
      log(e.toString());
      throw e;
    }
  }
}

class ProductImageModel extends ProductImage {
  const ProductImageModel({
    required super.image,
    required super.id
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    try {
      return ProductImageModel(image: json['image'],id: json['id'],);
    } catch (e, l) {
      log(l.toString());
      log(e.toString());
      throw e;
    }
  }
}

class ProductOptionModel extends ProductOptionEntity {
  ProductOptionModel({
    required super.id,
    required super.title,
  });

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) {
    return ProductOptionModel(
      id: json['id'],
      title: json['title'],
    );
  }
}

class TagModel extends TagEntity {
  TagModel({
    required super.id,
    required super.name,
    required super.time,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'],
      name: json['name'],
        time:DateTime.parse(json['created_at'])
    );
  }
}
class QuantityModel extends QuantityEntity {
  QuantityModel({
    required super.id,
    required super.storeProductID,
    required super.productVariantID,
    required super.quantity,
  });

  factory QuantityModel.fromJson(Map<String, dynamic> json) {
    return QuantityModel(
      id: json['id'],
      storeProductID: json['store_product_id'],
      productVariantID: convertStringToInt(json['product_variant_id']),
      quantity: convertDataToNum(json['quantity'])??0,
    );
  }
}
