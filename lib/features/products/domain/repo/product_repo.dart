import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entity/product_entity.dart';
import '../entity/variant_entity.dart';

abstract class ProductRepo {
  // User Products
  Future<Either<DioException, List<ProductOptionEntity>>> getVendorProductsOption(Map<String, dynamic> data,);
  Future<Either<DioException, List<TagEntity>>> getTags(Map<String, dynamic> data,);
  Future<Either<DioException, ProductEntity>> getProductVendorDetails(Map<String, dynamic> data,);
  Future<Either<DioException, ProductEntity>> createProduct(Map<String, dynamic> data,);
  Future<Either<DioException, VariantEntity>> createVariant(Map<String, dynamic> data,);
  Future<Either<DioException, VariantEntity>> updateVariant(Map<String, dynamic> data,);
  Future<Either<DioException, List<ProductEntity>>> getProducts(Map<String, dynamic> data,);
  Future<Either<DioException, bool>> deleteVariant(Map<String, dynamic> data,);
  Future<Either<DioException, ProductEntity>> updateProduct(
    Map<String, dynamic> data,
  );
  Future<Either<DioException, bool>> deleteProduct(Map<String, dynamic> data);
  Future<Either<DioException, QuantityEntity>> addProductToStore(Map<String, dynamic> data);
  Future<Either<DioException, bool>> removeStock(Map<String, dynamic> data);
}
