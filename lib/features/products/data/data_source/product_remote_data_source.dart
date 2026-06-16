import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../../../../core/helper_function/prefs.dart';
import '../../domain/entity/product_entity.dart';
import '../models/product_model.dart';
import '../models/variant_model.dart';

  class ProductRemoteDataSource {
  final ApiHandel apiHandel;
  ProductRemoteDataSource(this.apiHandel);

  Future<Either<DioException, List<ProductOptionModel>>> getVendorProductsOption(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.get('vendor/get_vendor_products_option', data,);
    List<ProductOptionModel> productModels = [];
    return response.fold((l) => Left(l), (r) {
      for (var i in r.data['data']) {
        productModels.add(ProductOptionModel.fromJson(i));
      }
      return Right(productModels);
    });
  }

  Future<Either<DioException, List<ProductEntity>>> getProducts(Map<String, dynamic> data,) async {
    bool isStore =sharedPreferences.getBool('isStore') ?? false;
    String userType =isStore ? 'store/get_store_products' : 'vendor/get_vendor_products';
    var response = await ApiHandel.getInstance.get('$userType', data);
    List<ProductModel> productModels = [];
    return response.fold((l) => Left(l), (r) {
      for (var i in r.data['data']) {
        productModels.add(ProductModel.fromJson(i));
      }
      return Right(productModels);
    });
  }

  Future<Either<DioException, List<TagModel>>> getTags(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.get('get_tags', data);
    List<TagModel> tags = [];
    return response.fold((l) => Left(l), (r) {
      for (var i in r.data['data']) {
        tags.add(TagModel.fromJson(i));
      }
      return Right(tags);
    });
  }

  Future<Either<DioException, ProductEntity>> createProduct(
      Map<String, dynamic> data,
      ) async {
    var response = await ApiHandel.getInstance.post('vendor/create_product', data,);
    return response.fold((l) => Left(l), (r) {
      return Right(ProductModel.fromJson(r.data['data']));
    });
  }


  Future<Either<DioException, ProductEntity>> updateProduct(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/update_product', data,);
    return response.fold((l) => Left(l), (r) {
      return Right(ProductModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, bool>> deleteProduct(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/delete_product', data,);
    return response.fold((l) => Left(l), (r) {
      return Right(r.data['data']);
    });
  }

  Future<Either<DioException, ProductEntity>> getProductVendorDetails(
      Map<String, dynamic> data,
      ) async {
    var response = await ApiHandel.getInstance.post('vendor/get_product_vendor_details', data,);
    return response.fold((l) {
      return Left(l);
    }, (r) {
      return Right(ProductModel.fromJson(r.data['data']));
    });
  }



  Future<Either<DioException, VariantModel>> createVariant(
      Map<String, dynamic> data,
      ) async {
    var response = await ApiHandel.getInstance.post('vendor/create_variant', data,);
    return response.fold((l) => Left(l), (r) {
      return Right(VariantModel.fromJson(r.data['data']));
    });
  }


  Future<Either<DioException, VariantModel>> updateVariant(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/update_variant', data,);
    return response.fold((l) => Left(l), (r) {
      return Right(VariantModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, bool>> deleteVariant(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/delete_variant', data,);
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }

  Future<Either<DioException, bool>> removeStock(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('store/remove_stock', data,);
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }

  Future<Either<DioException, QuantityModel>> addProductToStore(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('store/add_product_to_store', data,);
    return response.fold((l) => Left(l), (r) {
      return  Right(QuantityModel.fromJson(r.data['data']));
    });
  }


  }
