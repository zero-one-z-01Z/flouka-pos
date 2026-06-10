import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entity/category_entity.dart';
import '../entity/brand_entity.dart';
import '../entity/category_attributes_entity.dart';

abstract class CategoryRepo {
  Future<Either<DioException, List<CategoryEntity>>> getCategories();
  Future<Either<DioException, List<CategoryEntity>>> getMainCategories();
  Future<Either<DioException, List<BrandEntity>>> getCategoryBrands(Map<String,dynamic> data);
  Future<Either<DioException, List<CategoryAttributesEntity>>> getCategoryAttributes(Map<String,dynamic> data);

}
