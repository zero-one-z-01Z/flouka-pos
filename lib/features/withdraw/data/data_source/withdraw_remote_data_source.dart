import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../models/withdraw_model.dart';

class WithdrawRemoteDataSource {
  final ApiHandel apiHandel;
  WithdrawRemoteDataSource(this.apiHandel);

  Future<Either<DioException, WithdrawModel>> createWithdraw(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.post('vendor/create_withdraw', data,);
    return response.fold((l) => Left(l), (r) {
      return Right(WithdrawModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, List<WithdrawModel>>> getVendorWithdraws(Map<String, dynamic> data,) async {
    var response = await ApiHandel.getInstance.get('vendor/get_withdraw', data,);
    return response.fold((l) => Left(l), (r) {
      List<WithdrawModel> withdraws = [];
      for (var element in r.data['data']) {
        withdraws.add(WithdrawModel.fromJson(element));
      }
      return Right(withdraws);
    });
  }
}
