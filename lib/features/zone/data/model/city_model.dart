import '../../domain/entities/city_entity.dart';

class CityModel extends CityEntity {
  CityModel({required super.id, required super.name});

  factory CityModel.fromJson(Map data) {
    return CityModel(id: data['id'], name: data['name'] is String ? data['name'] : '');
  }
}
