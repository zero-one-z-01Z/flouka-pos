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

  static String _str(dynamic v) => v == null ? '' : v.toString().trim();

  static int _int(dynamic v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v?.toString() ?? '') ?? 0;
  }

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    final video = _str(
      json['video'] ?? json['video_url'] ?? json['media'] ?? json['media_url'],
    );
    final cover = _str(
      json['cover'] ?? json['thumbnail'] ?? json['image'] ?? video,
    );
    return ReelModel(
      id: _int(json['id']),
      vendorId: _int(json['vendor_id']),
      title: _str(json['title']),
      cover: cover.isNotEmpty ? cover : video,
      video: video.isNotEmpty ? video : cover,
      productId: _int(json['product_id']),
    );
  }
}
