import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flouka_pos/features/orders/data/data_source/order_remote_data_source.dart';
import 'package:flouka_pos/features/orders/domain/entity/order_entity.dart';
import 'package:flouka_pos/features/orders/domain/repo/order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  final OrderRemoteDataSource orderRemoteDataSource;
  OrderRepoImpl(this.orderRemoteDataSource);

  @override
  Future<Either<DioException, List<OrderEntity>>> getOrders(Map<String, dynamic> data,) {
    return orderRemoteDataSource.getUserOrders(data);
  }

  @override
  Future<Either<DioException, OrderEntity>> getOrderDetails(Map<String, dynamic> data,) {
    return orderRemoteDataSource.getOrderDetails(data);
  }

  @override
  Future<Either<DioException, bool>> rejectOrder(Map<String, dynamic> data,) {
    return orderRemoteDataSource.rejectOrder(data);
  }
  @override
  Future<Either<DioException, bool>> updateOrderStock(Map<String, dynamic> data,) {
    return orderRemoteDataSource.updateOrderStock(data);
  }
  @override
  Future<Either<DioException, bool>> updateVendorOrderStatus(Map<String, dynamic> data,) {
    return orderRemoteDataSource.updateVendorOrderStatus(data);
  }
}
