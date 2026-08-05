
import 'package:flouka_pos/core/helper_function/convert.dart';

import '../../domain/entity/store_entity.dart';

class StoreModel extends StoreEntity {
  const StoreModel({
    required super.id,
    required super.vendorId,
    super.name,
    super.phone,
    super.userName,
    super.lang,
    required  super.active,
    super.lat,
    super.lng,
    super.rate,
    super.address,
    super.token,
    super.createdAt,
    super.areaId,
    super.cityId,
    super.neighborhoodId,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      vendorId: json['vendor_id'],
      name: json['name'],
      phone: json['phone'],
      userName: json['user_name'],
      lang: json['lang'],
      active: convertDataToBool(json['active']),
      lat: convertDataToDouble(json['lat']),
      lng: convertDataToDouble(json['lng']),
      rate: convertDataToDouble(json['rate']),
      address: json['address'],
      token: json['token'],
      createdAt: json['created_at'],
      areaId: convertStringToIntNull(json['area_id']),
      neighborhoodId: convertStringToIntNull(json['neighborhood_id']),
      cityId: convertStringToIntNull(json['city_id']),
    );
  }

}


class StoreOptionModel extends StoreOption {
  const StoreOptionModel({
    required super.id,
    required super.vendorId,
    required super.name,
  });

  factory StoreOptionModel.fromJson(Map<String, dynamic> json) {
    return StoreOptionModel(
      id: json['id'],
      vendorId: json['vendor_id'],
      name: json['name'],
    );
  }

}