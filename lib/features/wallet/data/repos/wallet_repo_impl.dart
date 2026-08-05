import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/entity/wallet_operation_entity.dart';
import '../../domain/repo/wallet_repo.dart';
import '../data_source/wallet_remote_data_source.dart';

class WalletRepoImpl implements WalletRepo {
  final WalletRemoteDataSource walletRemoteDataSource;

  WalletRepoImpl(this.walletRemoteDataSource);

  @override
  Future<Either<DioException, List<WalletOperationEntity>>> getWalletOperations(Map<String, dynamic> data,) async {
    return await walletRemoteDataSource.getWalletOperations(data);
  }
}
