import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entity/store_entity.dart';
import '../repo/vendor_store_repo.dart';

class VendorStoresUseCase {
  final VendorStoreRepo vendorStoreRepo;

  VendorStoresUseCase(this.vendorStoreRepo);

  Future<Either<DioException, StoreEntity>> createStore(Map<String, dynamic> data,) async {
    return await vendorStoreRepo.createStore(data);
  }
  Future<Either<DioException, StoreEntity>> updateStore(Map<String, dynamic> data,) async {
    return await vendorStoreRepo.updateStore(data);
  }

  Future<Either<DioException, bool>> deleteStore(Map<String, dynamic> data,) async {
    return await vendorStoreRepo.deleteStore(data);
  }

  Future<Either<DioException, List<StoreOption>>> getVendorStoresOptions(Map<String, dynamic> data,) async {
    return await vendorStoreRepo.getVendorStoresOptions(data);
  }

  Future<Either<DioException, List<StoreEntity>>> getVendorStores(Map<String, dynamic> data,) async {
    return await vendorStoreRepo.getVendorStores(data);
  }

}
