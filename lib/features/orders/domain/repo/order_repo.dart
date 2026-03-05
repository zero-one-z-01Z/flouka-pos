import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flouka_pos/features/orders/domain/entity/order_entity.dart';

abstract class OrderRepo {
  Future<Either<DioException, List<OrderEntity>>> getOrders(
    Map<String, dynamic> data,
  );
}
