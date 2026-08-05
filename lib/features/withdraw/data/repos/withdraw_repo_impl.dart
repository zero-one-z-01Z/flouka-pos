import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/withdraw_entity.dart';
import '../../domain/repo/withdraw_repo.dart';
import '../data_source/withdraw_remote_data_source.dart';

class WithdrawRepoImpl implements WithdrawRepo {
  final WithdrawRemoteDataSource withdrawRemoteDataSource;

  WithdrawRepoImpl(this.withdrawRemoteDataSource);

  @override
  Future<Either<DioException, WithdrawEntity>> createWithdraw(Map<String, dynamic> data,) async {
    return await withdrawRemoteDataSource.createWithdraw(data);
  }

  @override
  Future<Either<DioException, List<WithdrawEntity>>> getVendorWithdraws(Map<String, dynamic> data,) async {
    return await withdrawRemoteDataSource.getVendorWithdraws(data);
  }
}
