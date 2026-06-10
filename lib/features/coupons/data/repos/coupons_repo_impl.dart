import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/coupon_entity.dart';
import '../../domain/repo/coupons_repo.dart';
import '../data_source/coupons_remote_data_source.dart';

class CouponsRepoImpl implements CouponsRepo {
  final CouponsRemoteDataSource couponsRemoteDataSource;

  CouponsRepoImpl(this.couponsRemoteDataSource);

  @override
  Future<Either<DioException, CouponEntity>> createCoupon(Map<String, dynamic> data,) async {
    return await couponsRemoteDataSource.createCoupon(data);
  }

  @override
  Future<Either<DioException, CouponEntity>> updateCoupon(Map<String, dynamic> data,) async {
    return await couponsRemoteDataSource.updateCoupon(data);
  }


  @override
  Future<Either<DioException, List<CouponEntity>>> getVendorCoupons(Map<String, dynamic> data,) async {
    return await couponsRemoteDataSource.getVendorCoupons(data);
  }

  @override
  Future<Either<DioException, bool>> deleteCoupon(Map<String, dynamic> data,) async {
    return await couponsRemoteDataSource.deleteCoupon(data);
  }
}
