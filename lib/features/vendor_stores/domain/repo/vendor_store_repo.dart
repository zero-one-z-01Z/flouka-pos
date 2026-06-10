import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entity/store_entity.dart';

abstract class VendorStoreRepo {
  Future<Either<DioException, List<StoreOption>>> getVendorStoresOptions(Map<String, dynamic> data,);
  Future<Either<DioException, List<StoreEntity>>> getVendorStores(Map<String, dynamic> data,);
  Future<Either<DioException, bool>> deleteStore(Map<String, dynamic> data,);
  Future<Either<DioException, StoreEntity>> createStore(Map<String, dynamic> data,);
  Future<Either<DioException, StoreEntity>> updateStore(Map<String, dynamic> data,);
}
