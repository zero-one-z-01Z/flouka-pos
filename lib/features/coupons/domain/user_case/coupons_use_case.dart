import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entity/coupon_entity.dart';
import '../repo/coupons_repo.dart';

class CouponsUseCase {
  final CouponsRepo couponsRepo;

  CouponsUseCase(this.couponsRepo);


  Future<Either<DioException, CouponEntity>> createCoupon(Map<String, dynamic> data,) async {
    return await couponsRepo.createCoupon(data);
  }

  Future<Either<DioException, CouponEntity>> updateCoupon(Map<String, dynamic> data,) async {
    return await couponsRepo.updateCoupon(data);
  }

  Future<Either<DioException, bool>> deleteCoupon(Map<String, dynamic> data,) async {
    return await couponsRepo.deleteCoupon(data);
  }

  Future<Either<DioException, List<CouponEntity>>> getVendorCoupons(Map<String, dynamic> data,) async {
    return await couponsRepo.getVendorCoupons(data);
  }


}
