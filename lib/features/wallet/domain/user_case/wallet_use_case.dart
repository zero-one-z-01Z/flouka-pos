import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entity/wallet_operation_entity.dart';
import '../repo/wallet_repo.dart';

class WalletUseCase {
  final WalletRepo walletRepo;

  WalletUseCase(this.walletRepo);

  Future<Either<DioException, List<WalletOperationEntity>>> getWalletOperations(Map<String, dynamic> data,) async {
    return await walletRepo.getWalletOperations(data);
  }
}
