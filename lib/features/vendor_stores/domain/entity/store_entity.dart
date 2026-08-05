import 'package:equatable/equatable.dart';

class StoreEntity {
  final int id;
  final int vendorId;
  final int? areaId;
  final int? cityId;
  final int? neighborhoodId;
  final String? name;
  final String? phone;
  final String? userName;
  final String? lang;
  final bool active;
  final double? lat;
  final double? lng;
  final double? rate;
  final String? address;
  final String? token;
  final String? createdAt;

  const StoreEntity({
    required this.id,
    required this.vendorId,
    required this.active,
    this.name,
    this.phone,
    this.userName,
    this.lang,
    this.lat,
    this.lng,
    this.rate,
    this.address,
    this.token,
    this.createdAt,
    this.areaId,
    this.cityId,
    this.neighborhoodId,
  });
}

class StoreOption extends Equatable{
  final int id;
  final int vendorId;
  final String name;
  const StoreOption({
    required this.id,
    required this.vendorId,
    required this.name,
  });
  @override
  List<Object?> get props => [id, vendorId, name];

}