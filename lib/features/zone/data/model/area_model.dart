import '../../domain/entities/area_entity.dart';
import 'city_model.dart';

class AreaModel extends AreaEntity {
  AreaModel({
    required super.id,
    required super.name,
    required super.cityEntity,
    required super.cityId,
  });

  factory AreaModel.fromJson(Map data) {
    return AreaModel(
      id: data['id'],
      name: data['name'] is String ? data['name'] : '',
      cityEntity: data['city'] != null ? CityModel.fromJson(data['city']) : null,
      cityId: data['city_id'],
    );
  }
}
