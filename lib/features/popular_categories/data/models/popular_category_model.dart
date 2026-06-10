import 'package:flouka_pos/core/helper_function/convert.dart';

import '../../../products/data/models/product_model.dart';
import '../../../vendor_stores/data/models/store_model.dart';
import '../../domain/entity/popular_category_entity.dart';

class PopularCategoryModel extends PopularCategoryEntity {
  const PopularCategoryModel({
    required super.id,
    required super.productsIds,
    required super.image,
    required super.name,
    required super.startDate,
    required super.endDate,
  });

  factory PopularCategoryModel.fromJson(Map<String, dynamic> json) {
    return PopularCategoryModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      productsIds: (json['product_ids'] as List?)!.map((e) => e as int).toList(),
    );
  }

}

