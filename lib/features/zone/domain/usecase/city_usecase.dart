import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entities/area_entity.dart';
import '../entities/city_entity.dart';
import '../entities/neighborhood_entity.dart';
import '../repository/city_repo.dart';

class CityUseCases {
  CityRepo cityRepo;

  CityUseCases(this.cityRepo);

  Future<Either<DioException, List<CityEntity>>> getCities() async {
    return await cityRepo.getCities();
  }

  Future<Either<DioException, List<AreaEntity>>> getArea(
    Map<String, dynamic> data,
  ) async {
    return await cityRepo.getArea(data);
  }
  Future<Either<DioException, List<NeighborhoodEntity>>> getNeighborhoods(
    Map<String, dynamic> data,
  ) async {
    return await cityRepo.getNeighborhoods(data);
  }
}
