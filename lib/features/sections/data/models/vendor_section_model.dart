import 'package:flouka_pos/core/helper_function/convert.dart';

import '../../../products/data/models/product_model.dart';
import '../../../vendor_stores/data/models/store_model.dart';
import '../../domain/entity/vendor_section_entity.dart';

class VendorSectionModel extends VendorSectionEntity {
  const VendorSectionModel({
    required super.id,
    required super.productsIds,
    required super.title,
  });

  factory VendorSectionModel.fromJson(Map<String, dynamic> json) {
    return VendorSectionModel(
      id: json['id'],
      title: json['title'],
      productsIds: (json['product_ids'] as List?)!.map((e) => e as int).toList(),
    );
  }

}

