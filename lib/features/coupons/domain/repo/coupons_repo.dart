import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entity/coupon_entity.dart';

abstract class CouponsRepo {
  Future<Either<DioException, bool>> deleteCoupon(Map<String, dynamic> data,);
  Future<Either<DioException, CouponEntity>> updateCoupon(Map<String, dynamic> data,);
  Future<Either<DioException, CouponEntity>> createCoupon(Map<String, dynamic> data,);
  Future<Either<DioException, List<CouponEntity>>> getVendorCoupons(Map<String, dynamic> data,);
}
