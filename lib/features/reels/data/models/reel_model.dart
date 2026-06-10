
import 'package:flouka_pos/core/helper_function/convert.dart';

import '../../domain/entity/reel_entity.dart';

class ReelModel extends ReelEntity {
  const ReelModel({
    required super.id,
    required super.vendorId,
    required super.title,
    required super.cover,
    required super.video,
    required super.productId,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      id: json['id'],
      vendorId: json['vendor_id'],
      title: json['title'],
      cover: json['cover'],
      video: json['video'],
      productId: json['product_id'],
    );
  }

}
