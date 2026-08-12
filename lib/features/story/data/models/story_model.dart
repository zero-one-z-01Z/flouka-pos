import '../../domain/entity/story_entity.dart';

class StoryModel extends StoryEntity {
  const StoryModel({
    required super.id,
    required super.vendorId,
    required super.title,
    required super.image,
    required super.productId,
  });

  static String _str(dynamic v) => v == null ? '' : v.toString().trim();

  static int _int(dynamic v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v?.toString() ?? '') ?? 0;
  }

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    final image = _str(
      json['image'] ?? json['media'] ?? json['media_url'] ?? json['cover'],
    );
    return StoryModel(
      id: _int(json['id']),
      vendorId: _int(json['vendor_id']),
      title: _str(json['title']),
      image: image,
      productId: _int(json['product_id']),
    );
  }
}
