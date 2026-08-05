import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/repository/city_repo.dart';
import '../datasource/city_remote.dart';
import '../model/area_model.dart';
import '../model/city_model.dart';
import '../model/neighborhood_model.dart';

class CityRepoImpl implements CityRepo {
  final CityRemoteDataSource cityRemoteDataSource;

  CityRepoImpl(this.cityRemoteDataSource);

  @override
  Future<Either<DioException, List<CityModel>>> getCities() async {
    return await cityRemoteDataSource.getCities();
  }

  @override
  Future<Either<DioException, List<AreaModel>>> getArea(
    Map<String, dynamic> data,
  ) async {
    return await cityRemoteDataSource.getArea(data);
  }

  @override
  Future<Either<DioException, List<NeighborhoodModel>>> getNeighborhoods(Map<String, dynamic> data) async{
    return await cityRemoteDataSource.getNeighborhoods(data);
  }
}
