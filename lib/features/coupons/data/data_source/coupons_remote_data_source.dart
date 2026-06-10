import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../../domain/entity/coupon_entity.dart';
import '../models/coupon_model.dart';

  class CouponsRemoteDataSource {
  final ApiHandel apiHandel;
  CouponsRemoteDataSource(this.apiHandel);

  Future<Either<DioException, CouponModel>> createCoupon(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/create_coupon', data,);
    return response.fold((l) => Left(l), (r) {
      return Right(CouponModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, CouponModel>> updateCoupon(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/update_coupon', data,);
    return response.fold((l) => Left(l), (r) {
      return Right(CouponModel.fromJson(r.data['data']));
    });
  }


  Future<Either<DioException, List<CouponModel>>> getVendorCoupons(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.get('vendor/get_vendor_coupons', data,);
    return response.fold((l) => Left(l), (r) {
      List<CouponModel> stories = [];
      for(var element in r.data['data']){
        stories.add(CouponModel.fromJson(element));
      }
      return Right(stories);
    });
  }

  Future<Either<DioException, bool>> deleteCoupon(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/delete_coupon', data,);
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }


}
