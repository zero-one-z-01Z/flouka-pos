import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../../domain/entity/popular_category_entity.dart';
import '../models/popular_category_model.dart';

    class PopularCategoryRemoteDataSource {
  final ApiHandel apiHandel;
  PopularCategoryRemoteDataSource(this.apiHandel);

  Future<Either<DioException, bool>> assignProductsToPopularCategories(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/assign_products_to_popular_categories', data,);
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }

  Future<Either<DioException, List<PopularCategoryModel>>> getPopularCategories(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.get('vendor/get_popular_vendor_categories', data,);
    return response.fold((l) => Left(l), (r) {
      List<PopularCategoryModel> stories = [];
      for(var element in r.data['data']){
        stories.add(PopularCategoryModel.fromJson(element));
      }
      return Right(stories);
    });
  }

}
