import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/helper_function/api.dart';
import '../model/brand_model.dart';
import '../model/category_attributes_model.dart';
import '../model/category_model.dart';

class CategoryRemoteDataSource {
  final ApiHandel apiHandel;

  CategoryRemoteDataSource(this.apiHandel);

  Future<Either<DioException, List<CategoryModel>>> getCategories() async {
    var response = await apiHandel.get('get_categories', {'with_children': 1});
    return response.fold((l) => Left(l), (r) {
      List<CategoryModel> list = [];
      for (var i in r.data['data']) {
        list.add(CategoryModel.fromJson(i));
      }
      return Right(list);
    });
  }

  Future<Either<DioException, List<CategoryModel>>> getMainCategories() async {
    var response = await apiHandel.get('get_categories', {'with_parent': 1});
    return response.fold((l) => Left(l), (r) {
      List<CategoryModel> list = [];
      for (var i in r.data['data']) {
        list.add(CategoryModel.fromJson(i));
      }
      return Right(list);
    });
  }

  Future<Either<DioException, List<BrandModel>>> getCategoryBrands(Map<String,dynamic> data) async {
    List<BrandModel> filterModels = [];
    var response = await apiHandel.post('get_brands',data);
    return response.fold((l) => Left(l), (r) {
      for (var i in r.data['data']) {
        filterModels.add(BrandModel.fromJson(i));
      }
      return Right(filterModels);
    });
  }

  Future<Either<DioException, List<CategoryAttributesModel>>> getCategoryAttributes(Map<String,dynamic> data) async {
    List<CategoryAttributesModel> filterModels = [];
    var response = await apiHandel.post('get_attributes',data);
    return response.fold((l) => Left(l), (r) {
      for (var i in r.data['data']) {
        filterModels.add(CategoryAttributesModel.fromJson(i));
      }
      return Right(filterModels);
    });
  }

}
