import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../datasource/category_remote_data_source.dart';
import '../../domain/repositories/category_repo.dart';
import '../model/brand_model.dart';
import '../model/category_attributes_model.dart';
import '../model/category_model.dart';

class CategoryRepoImpl implements CategoryRepo {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepoImpl(this.categoryRemoteDataSource);

  @override
  Future<Either<DioException, List<CategoryModel>>> getCategories() async {
    return await categoryRemoteDataSource.getCategories();
  }

  @override
  Future<Either<DioException, List<CategoryModel>>> getMainCategories() async {
    return await categoryRemoteDataSource.getMainCategories();
  }

  @override
  Future<Either<DioException, List<BrandModel>>> getCategoryBrands(Map<String,dynamic> data) {
    return categoryRemoteDataSource.getCategoryBrands(data);
  }

  @override
  Future<Either<DioException, List<CategoryAttributesModel>>> getCategoryAttributes(Map<String,dynamic> data) {
    return categoryRemoteDataSource.getCategoryAttributes(data);
  }

}
