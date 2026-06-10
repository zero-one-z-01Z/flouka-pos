
import '../../domain/entity/brand_entity.dart';

class BrandModel extends BrandEntity {
  const BrandModel({required super.id, required super.name,required super.image});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(id: json['id'], name: json['name'],image: json['image']);
  }
}
