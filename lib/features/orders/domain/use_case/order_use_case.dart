import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entity/order_details_entity.dart';
import '../entity/order_entity.dart';
import '../repo/order_repo.dart';

class OrderUseCase {
  final OrderRepo orderRepo;
  OrderUseCase(this.orderRepo);

  Future<Either<DioException, List<OrderEntity>>> getOrders(
    Map<String, dynamic> data,
  ) {
    return orderRepo.getOrders(data);
  }

  Future<Either<DioException, OrderDetailsEntity>> getOrderDetails(
    Map<String, dynamic> data,
  ) {
    return orderRepo.getOrderDetails(data);
  }
}
