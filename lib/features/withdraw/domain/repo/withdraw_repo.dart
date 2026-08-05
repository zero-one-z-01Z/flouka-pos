import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entity/withdraw_entity.dart';

abstract class WithdrawRepo {
  Future<Either<DioException, WithdrawEntity>> createWithdraw(Map<String, dynamic> data,);
  Future<Either<DioException, List<WithdrawEntity>>> getVendorWithdraws(Map<String, dynamic> data,);
}
