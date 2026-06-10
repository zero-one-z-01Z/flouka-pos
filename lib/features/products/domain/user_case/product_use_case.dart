import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entity/product_entity.dart';
import '../entity/variant_entity.dart';
import '../repo/product_repo.dart';

class ProductUseCase {
  final ProductRepo productRepo;

  ProductUseCase(this.productRepo);

  Future<Either<DioException, List<ProductOptionEntity>>> getVendorProductsOption(Map<String, dynamic> data,) async {
    return await productRepo.getVendorProductsOption(data);
  }

  Future<Either<DioException, List<TagEntity>>> getTags(Map<String, dynamic> data,) async {
    return await productRepo.getTags(data);
  }


  Future<Either<DioException, ProductEntity>> createProduct(
    Map<String, dynamic> data,
  ) async {
    return await productRepo.createProduct(data);
  }

  Future<Either<DioException, bool>> deleteProduct(
    Map<String, dynamic> data,
  ) async {
    return await productRepo.deleteProduct(data);
  }

  Future<Either<DioException, bool>> deleteVariant(
    Map<String, dynamic> data,
  ) async {
    return await productRepo.deleteVariant(data);
  }


  Future<Either<DioException, List<ProductEntity>>> getFeatures() async {
    return await productRepo.getProducts({});
  }

  Future<Either<DioException, ProductEntity>> getProductVendorDetails(Map<String, dynamic> data,) async {
    return await productRepo.getProductVendorDetails(data);
  }


  Future<Either<DioException, List<ProductEntity>>> getProducts(
    Map<String, dynamic> data,
  ) async {
    return await productRepo.getProducts(data);
  }

  Future<Either<DioException, ProductEntity>> updateProduct(
    Map<String, dynamic> data,
  ) async {
    return await productRepo.updateProduct(data);
  }

  Future<Either<DioException, VariantEntity>> createVariant(Map<String, dynamic> data,) async {
    return await productRepo.createVariant(data);
  }

  Future<Either<DioException, VariantEntity>> updateVariant(Map<String, dynamic> data,) async {
    return await productRepo.updateVariant(data);
  }
  Future<Either<DioException, bool>> removeStock(Map<String, dynamic> data,) async {
    return await productRepo.removeStock(data);
  }
  Future<Either<DioException, QuantityEntity>> addProductToStore(Map<String, dynamic> data,) async {
    return await productRepo.addProductToStore(data);
  }


}
