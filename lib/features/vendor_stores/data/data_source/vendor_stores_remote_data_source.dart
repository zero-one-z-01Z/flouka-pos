import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../../domain/entity/store_entity.dart';
import '../models/store_model.dart';

  class VendorStoresRemoteDataSource {
  final ApiHandel apiHandel;
  VendorStoresRemoteDataSource(this.apiHandel);

  Future<Either<DioException, List<StoreModel>>> getVendorStores(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.get('vendor/get_vendor_stores', data,);
    List<StoreModel> stores = [];
    return response.fold((l) => Left(l), (r) {
      for (var i in r.data['data']) {
        stores.add(StoreModel.fromJson(i));
      }
      return Right(stores);
    });
  }

  Future<Either<DioException, StoreModel>> createStore(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/create_store', data,);
    return response.fold((l) => Left(l), (r) {
      return Right(StoreModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, StoreModel>> updateStore(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/update_store', data,);
    return response.fold((l) => Left(l), (r) {
      return Right(StoreModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, bool>> deleteStore(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/delete_store', data,);
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }

  Future<Either<DioException, List<StoreOptionModel>>> getVendorStoresOptions(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.get('vendor/get_vendor_stores_options', data,);
    List<StoreOptionModel> stores = [];
    return response.fold((l) => Left(l), (r) {
      for (var i in r.data['data']) {
        stores.add(StoreOptionModel.fromJson(i));
      }
      return Right(stores);
    });
  }

}
