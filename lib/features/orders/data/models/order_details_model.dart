import 'package:flouka_pos/core/helper_function/convert.dart';
import 'package:flouka_pos/features/orders/domain/entity/order_details_entity.dart';

class OrderDetailsModel extends OrderDetailsEntity {
  OrderDetailsModel({
    required super.id,
    required super.userName,
    required super.userPhone,
    required super.subtotal,
    required super.total,
    required super.tax,
    required super.fees,
    required super.paymentMethod,
    required super.orderTime,
    required super.itemCount,
    required super.address,
    required super.status,
    required super.items,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      id: json['id'],
      userName: json['user_name'],
      userPhone: json['user_phone'],
      subtotal: convertDataToNumNull(json['subtotal']),
      total: convertDataToNumNull(json['total']),
      tax: convertDataToNumNull(json['tax']),
      fees: convertDataToNumNull(json['fees']),
      paymentMethod: json['payment_method'],
      orderTime: json['order_time'],
      itemCount: json['item_count'],
      address: json['address'],
      status: json['status'],
      items: (json['items'] as List).map((e) => OrderItemModel.fromJson(e)).toList(),
    );
  }
}

class OrderItemModel extends OrderItemEntity {
  OrderItemModel({
    required super.id,
    required super.quantity,
    required super.title,
    required super.price,
    required super.avgRating,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      quantity: json['quantity'],
      title: json['title'],
      price: convertDataToNumNull(json['price']),
      avgRating: json['avg_rating'],
    );
  }
}
