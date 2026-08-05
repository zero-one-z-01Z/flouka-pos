import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entity/withdraw_entity.dart';
import '../repo/withdraw_repo.dart';

class WithdrawUseCase {
  final WithdrawRepo withdrawRepo;

  WithdrawUseCase(this.withdrawRepo);

  Future<Either<DioException, WithdrawEntity>> createWithdraw(Map<String, dynamic> data,) async {
    return await withdrawRepo.createWithdraw(data);
  }

  Future<Either<DioException, List<WithdrawEntity>>> getVendorWithdraws(Map<String, dynamic> data,) async {
    return await withdrawRepo.getVendorWithdraws(data);
  }
}
