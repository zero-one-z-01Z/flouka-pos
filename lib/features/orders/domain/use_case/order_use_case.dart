import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../entity/order_entity.dart';
import '../repo/order_repo.dart';

class OrderUseCase {
  final OrderRepo orderRepo;
  OrderUseCase(this.orderRepo);

  Future<Either<DioException, List<OrderEntity>>> getOrders(Map<String, dynamic> data,) {
    return orderRepo.getOrders(data);
  }

  Future<Either<DioException, OrderEntity>> getOrderDetails(Map<String, dynamic> data,) {
    return orderRepo.getOrderDetails(data);
  }

  Future<Either<DioException, bool>> rejectOrder(Map<String, dynamic> data,) {
    return orderRepo.rejectOrder(data);
  }

  Future<Either<DioException, bool>> updateOrderStock(Map<String, dynamic> data,) {
    return orderRepo.updateOrderStock(data);
  }

  Future<Either<DioException, bool>> updateVendorOrderStatus(Map<String, dynamic> data,) {
    return orderRepo.updateVendorOrderStatus(data);
  }
}
