import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entity/popular_category_entity.dart';

abstract class PopularCategoryRepo {
  Future<Either<DioException, bool>> assignProductsToPopularCategories(Map<String, dynamic> data,);
  Future<Either<DioException, List<PopularCategoryEntity>>> getPopularCategories(Map<String, dynamic> data,);
}
