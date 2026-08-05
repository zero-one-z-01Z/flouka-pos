import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../entity/wallet_operation_entity.dart';

abstract class WalletRepo {
  Future<Either<DioException, List<WalletOperationEntity>>> getWalletOperations(Map<String, dynamic> data,);
}
