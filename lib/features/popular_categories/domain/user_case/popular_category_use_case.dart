import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entity/popular_category_entity.dart';
import '../repo/popular_category_repo.dart';

class PopularCategoryUseCase {
  final PopularCategoryRepo popularCategoryRepo;

  PopularCategoryUseCase(this.popularCategoryRepo);


  Future<Either<DioException, bool>> assignProductsToPopularCategories(Map<String, dynamic> data,) async {
    return await popularCategoryRepo.assignProductsToPopularCategories(data);
  }

  Future<Either<DioException, List<PopularCategoryEntity>>> getPopularCategories(Map<String, dynamic> data,) async {
    return await popularCategoryRepo.getPopularCategories(data);
  }


}
