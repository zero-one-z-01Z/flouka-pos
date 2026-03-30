import 'package:flouka_pos/features/orders/domain/entity/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required int id,
    required String userName,
    required String total,
    required String paymentMethod,
    required String orderTime,
    required int itemCount,
    required String address,
    required String status,
  }) : super(
         id: id,
         userName: userName,
         total: total,
         paymentMethod: paymentMethod,
         orderTime: orderTime,
         itemCount: itemCount,
         address: address,
         status: status,
       );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userName: json['user_name'],
      total: json['total'],
      paymentMethod: json['payment_method'],
      orderTime: json['order_time'],
      itemCount: json['item_count'],
      address: json['address'],
      status: json['status'],
    );
  }
}
