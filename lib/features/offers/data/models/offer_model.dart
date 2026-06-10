import 'package:flouka_pos/core/helper_function/convert.dart';

import '../../../products/data/models/product_model.dart';
import '../../../vendor_stores/data/models/store_model.dart';
import '../../domain/entity/offer_entity.dart';

class OfferModel extends OfferEntity {
  const OfferModel({
    required super.id,
    required super.vendorId,
    required super.name,
    required super.products,
    required super.percentage,
    required super.createdAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      vendorId: json['vendor_id'],
      name: json['name'],
      percentage: convertDataToNum(json['percentage'])??0,
      createdAt: DateTime.parse(json['created_at']),
      products: (json['products'] as List?)!.map((e) => ProductOptionModel.fromJson(e)).toList(),
    );
  }

}

