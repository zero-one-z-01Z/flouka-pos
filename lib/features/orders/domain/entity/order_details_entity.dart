class OrderDetailsEntity {
  final int id;
  final String userName;
  final String userPhone;
  final num? subtotal;
  final num? total;
  final num? tax;
  final num? fees;
  final String paymentMethod;
  final String orderTime;
  final int itemCount;
  final String address;
  final String status;
  final List<OrderItemEntity> items;

  OrderDetailsEntity({
    required this.id,
    required this.userName,
    required this.userPhone,
    required this.subtotal,
    required this.total,
    required this.tax,
    required this.fees,
    required this.paymentMethod,
    required this.orderTime,
    required this.itemCount,
    required this.address,
    required this.status,
    required this.items,
  });
}

class OrderItemEntity {
  final int id;
  final int quantity;
  final String title;
  final num? price;
  final String avgRating;

  OrderItemEntity({
    required this.id,
    required this.quantity,
    required this.title,
    required this.price,
    required this.avgRating,
  });
}
