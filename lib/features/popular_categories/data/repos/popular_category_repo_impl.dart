import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/popular_category_entity.dart';
import '../../domain/repo/popular_category_repo.dart';
import '../data_source/popular_category_remote_data_source.dart';
import '../models/popular_category_model.dart';

class PopularCategoryRepoImpl implements PopularCategoryRepo {
  final PopularCategoryRemoteDataSource popularCategoryRemoteDataSource;

  PopularCategoryRepoImpl(this.popularCategoryRemoteDataSource);

  @override
  Future<Either<DioException, bool>> assignProductsToPopularCategories(Map<String, dynamic> data,) async {
    return await popularCategoryRemoteDataSource.assignProductsToPopularCategories(data);
  }

  @override
  Future<Either<DioException, List<PopularCategoryModel>>> getPopularCategories(Map<String, dynamic> data,) async {
    return await popularCategoryRemoteDataSource.getPopularCategories(data);
  }
}
