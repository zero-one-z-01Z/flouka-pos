
import 'package:flouka_pos/core/helper_function/convert.dart';

import '../../domain/entity/story_entity.dart';

class StoryModel extends StoryEntity {
  const StoryModel({
    required super.id,
    required super.vendorId,
    required super.title,
    required super.image,
    required super.productId,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      vendorId: json['vendor_id'],
      title: json['title'],
      image: json['image'],
      productId: json['product_id'],
    );
  }

}
