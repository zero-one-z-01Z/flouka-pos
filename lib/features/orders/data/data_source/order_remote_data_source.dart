import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/helper_function/api.dart';
import '../../../../core/helper_function/prefs.dart';
import '../models/order_model.dart';

class OrderRemoteDataSource {
  final ApiHandel apiHandel;
  OrderRemoteDataSource(this.apiHandel);

  Future<Either<DioException, List<OrderModel>>> getUserOrders(Map<String, dynamic> data,) async {
    bool isStore =sharedPreferences.getBool('isStore') ?? false;
    String userType =isStore ? 'store' : 'vendor';

    var response = await apiHandel.post('$userType/get_vendor_orders', data);
    return response.fold((l) => Left(l), (r) {
      List<OrderModel> orderModels = [];
      for (var i in r.data['data']) {
        orderModels.add(OrderModel.fromJson(i));
      }
      return Right(orderModels);
    });
  }

  Future<Either<DioException, OrderModel>> getOrderDetails(
    Map<String, dynamic> data,
  ) async {
    bool isStore =sharedPreferences.getBool('isStore') ?? false;
    String userType =isStore ? 'store' : 'vendor';

    var response = await apiHandel.post('$userType/get_vendor_order_details', data);
    return response.fold((l) => Left(l), (r) {
      return Right(OrderModel.fromJson(r.data['data']));
    });
  }

  Future<Either<DioException, bool>> rejectOrder(Map<String, dynamic> data, ) async {
    bool isStore =sharedPreferences.getBool('isStore') ?? false;
    String userType =isStore ? 'store' : 'vendor';

    var response = await apiHandel.post('$userType/reject_order', data);
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }

  Future<Either<DioException, bool>> updateOrderStock(Map<String, dynamic> data,) async {
    bool isStore =sharedPreferences.getBool('isStore') ?? false;
    String userType =isStore ? 'store' : 'vendor';

    var response = await apiHandel.post('$userType/update_order_stock', data);
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }

  Future<Either<DioException, bool>> updateVendorOrderStatus(Map<String, dynamic> data, ) async {
    bool isStore =sharedPreferences.getBool('isStore') ?? false;
    String userType =isStore ? 'store' : 'vendor';

    var response = await apiHandel.post('$userType/update_vendor_order_status', data);
    return response.fold((l) => Left(l), (r) {
      return const Right(true);
    });
  }
}
