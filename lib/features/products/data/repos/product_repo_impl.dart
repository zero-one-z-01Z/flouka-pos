import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/product_entity.dart';
import '../../domain/entity/variant_entity.dart';
import '../../domain/repo/product_repo.dart';
import '../data_source/product_remote_data_source.dart';
import '../models/product_model.dart';
import '../models/variant_model.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepoImpl(this.productRemoteDataSource);

  @override
  Future<Either<DioException, List<ProductOptionModel>>> getVendorProductsOption(Map<String, dynamic> data,) async {
    return await productRemoteDataSource.getVendorProductsOption(data);
  }

  @override
  Future<Either<DioException, List<TagModel>>> getTags(Map<String, dynamic> data,) async {
    return await productRemoteDataSource.getTags(data);
  }

  @override
  Future<Either<DioException, ProductEntity>> createProduct(Map<String, dynamic> data,) async {
    return await productRemoteDataSource.createProduct(data);
  }

  @override
  Future<Either<DioException, ProductEntity>> getProductVendorDetails(Map<String, dynamic> data,) async {
    return await productRemoteDataSource.getProductVendorDetails(data);
  }

  @override
  Future<Either<DioException, bool>> deleteProduct(
    Map<String, dynamic> data,
  ) async {
    return await productRemoteDataSource.deleteProduct(data);
  }


  @override
  Future<Either<DioException, VariantModel>> createVariant(
    Map<String, dynamic> data,
  ) async {
    return await productRemoteDataSource.createVariant(data);
  }

  @override
  Future<Either<DioException, bool>> deleteVariant(Map<String, dynamic> data) async {
    return await productRemoteDataSource.deleteVariant(data);
  }


  @override
  Future<Either<DioException, VariantModel>> updateVariant(
    Map<String, dynamic> data,
  ) async {
    return await productRemoteDataSource.updateVariant(data);
  }



  @override
  Future<Either<DioException, List<ProductEntity>>> getProducts(
    Map<String, dynamic> data,
  ) async {
    return await productRemoteDataSource.getProducts(data);
  }

  @override
  Future<Either<DioException, ProductEntity>> updateProduct(
    Map<String, dynamic> data,
  ) async {
    return await productRemoteDataSource.updateProduct(data);
  }

  @override
  Future<Either<DioException, QuantityModel>> addProductToStore(
      Map<String, dynamic> data,
      ) async {
    return await productRemoteDataSource.addProductToStore(data);
  }


  @override
  Future<Either<DioException, bool>> removeStock(
      Map<String, dynamic> data,
      ) async {
    return await productRemoteDataSource.removeStock(data);
  }



}
