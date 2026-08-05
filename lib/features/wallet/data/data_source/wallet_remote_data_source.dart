import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../models/wallet_operation_model.dart';

class WalletRemoteDataSource {
  final ApiHandel apiHandel;
  WalletRemoteDataSource(this.apiHandel);

  Future<Either<DioException, List<WalletOperationModel>>> getWalletOperations(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.get('vendor/get_wallet_operations', data,);
    return response.fold((l) => Left(l), (r) {
      List<WalletOperationModel> operations = [];
      for (var element in r.data['data']) {
        operations.add(WalletOperationModel.fromJson(element));
      }
      return Right(operations);
    });
  }
}
