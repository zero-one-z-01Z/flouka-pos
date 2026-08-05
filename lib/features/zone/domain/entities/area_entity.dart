import 'package:equatable/equatable.dart';

import 'city_entity.dart';

class AreaEntity extends Equatable{
  int id;
  int cityId;
  String name;
  CityEntity? cityEntity;
  AreaEntity({
    required this.id,
    required this.name,
    required this.cityEntity,
    required this.cityId,
  });

  @override
  List<Object?> get props => [id,cityId,name];
}
