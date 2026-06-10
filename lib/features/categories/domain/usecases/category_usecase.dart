import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entity/brand_entity.dart';
import '../entity/category_attributes_entity.dart';
import '../entity/category_entity.dart';
import '../repositories/category_repo.dart';

class CategoryUsecase {
  final CategoryRepo categoryRepo;
  CategoryUsecase(this.categoryRepo);

  Future<Either<DioException, List<CategoryEntity>>> getCategories() async {
    return await categoryRepo.getCategories();
  }

  Future<Either<DioException, List<CategoryEntity>>> getMainCategories() async {
    return await categoryRepo.getMainCategories();
  }

  Future<Either<DioException, List<BrandEntity>>> getCategoryBrands(Map<String,dynamic> data) {
    return categoryRepo.getCategoryBrands(data);
  }

  Future<Either<DioException, List<CategoryAttributesEntity>>> getCategoryAttributes(Map<String,dynamic> data) {
    return categoryRepo.getCategoryAttributes(data);
  }

}
