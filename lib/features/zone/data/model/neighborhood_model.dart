

import '../../domain/entities/neighborhood_entity.dart';

class NeighborhoodModel extends NeighborhoodEntity {
  NeighborhoodModel({
    required super.id,
    required super.name,
    required super.areaId,
  });

  factory NeighborhoodModel.fromJson(Map data) {
    return NeighborhoodModel(
      id: data['id'],
      name: data['name'] is String ? data['name'] : '',
      areaId: data['area_id'],
    );
  }
}
