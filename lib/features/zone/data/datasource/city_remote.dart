import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/helper_function/api.dart';
import '../model/area_model.dart';
import '../model/city_model.dart';
import '../model/neighborhood_model.dart';

class CityRemoteDataSource {
  final ApiHandel apiHandel;
  CityRemoteDataSource(this.apiHandel);

  Future<Either<DioException, List<CityModel>>> getCities() async {
    var response = await apiHandel.get('get_cities', {});
    return response.fold((l) => Left(l), (r) {
      List<CityModel> list = [];
      for (var i in r.data['data']) {
        list.add(CityModel.fromJson(i));
      }
      return Right(list);
    });
  }

  Future<Either<DioException, List<AreaModel>>> getArea(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.post('get_areas', data);
    return response.fold((l) => Left(l), (r) {
      List<AreaModel> list = [];
      for (var i in r.data['data']) {
        list.add(AreaModel.fromJson(i));
      }
      return Right(list);
    });
  }
  Future<Either<DioException, List<NeighborhoodModel>>> getNeighborhoods(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.post('get_neighborhoods', data);
    return response.fold((l) => Left(l), (r) {
      List<NeighborhoodModel> list = [];
      for (var i in r.data['data']) {
        list.add(NeighborhoodModel.fromJson(i));
      }
      return Right(list);
    });
  }
}
