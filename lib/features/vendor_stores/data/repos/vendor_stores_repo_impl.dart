import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/store_entity.dart';
import '../../domain/repo/vendor_store_repo.dart';
import '../data_source/vendor_stores_remote_data_source.dart';

class VendorStoresRepoImpl implements VendorStoreRepo {
  final VendorStoresRemoteDataSource storesRemoteDataSource;

  VendorStoresRepoImpl(this.storesRemoteDataSource);

  @override
  Future<Either<DioException, StoreEntity>> createStore(
    Map<String, dynamic> data,
  ) async {
    return await storesRemoteDataSource.createStore(data);
  }

  @override
  Future<Either<DioException, StoreEntity>> updateStore(
      Map<String, dynamic> data,
      ) async {
    return await storesRemoteDataSource.updateStore(data);
  }

  @override
  Future<Either<DioException, bool>> deleteStore(
    Map<String, dynamic> data,
  ) async {
    return await storesRemoteDataSource.deleteStore(data);
  }



  @override
  Future<Either<DioException, List<StoreEntity>>> getVendorStores(
    Map<String, dynamic> data,
  ) async {
    return await storesRemoteDataSource.getVendorStores(data);
  }

  @override
  Future<Either<DioException, List<StoreOption>>> getVendorStoresOptions(
    Map<String, dynamic> data,
  ) async {
    return await storesRemoteDataSource.getVendorStoresOptions(data);
  }

}
