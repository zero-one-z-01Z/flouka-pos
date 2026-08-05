import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entities/area_entity.dart';
import '../entities/city_entity.dart';
import '../entities/neighborhood_entity.dart';

abstract class CityRepo {
  Future<Either<DioException, List<CityEntity>>> getCities();
  Future<Either<DioException, List<AreaEntity>>> getArea(Map<String,dynamic> data);
  Future<Either<DioException, List<NeighborhoodEntity>>> getNeighborhoods(Map<String,dynamic> data);
}