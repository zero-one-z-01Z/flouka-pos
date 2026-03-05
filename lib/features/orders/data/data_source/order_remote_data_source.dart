import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/helper_function/api.dart';
import '../models/order_model.dart';

class OrderRemoteDataSource {
  final ApiHandel apiHandel;
  OrderRemoteDataSource(this.apiHandel);

  Future<Either<DioException, List<OrderModel>>> getUserOrders(
    Map<String, dynamic> data,
  ) async {
    var response = await apiHandel.get('store/orders', data);
    return response.fold((l) => Left(l), (r) {
      List<OrderModel> orderModels = [];
      for (var i in r.data['data']) {
        orderModels.add(OrderModel.fromJson(i));
      }
      return Right(orderModels);
    });
  }
}
