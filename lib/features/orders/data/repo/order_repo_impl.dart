import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flouka_pos/features/orders/data/data_source/order_remote_data_source.dart';
import 'package:flouka_pos/features/orders/domain/entity/order_entity.dart';
import 'package:flouka_pos/features/orders/domain/repo/order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  final OrderRemoteDataSource orderRemoteDataSource;
  OrderRepoImpl(this.orderRemoteDataSource);

  @override
  Future<Either<DioException, List<OrderEntity>>> getOrders(
    Map<String, dynamic> data,
  ) {
    return orderRemoteDataSource.getUserOrders(data);
  }
}
