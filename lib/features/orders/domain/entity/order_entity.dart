class OrderEntity {
  final int id;
  final String userName;
  final String total;
  final String paymentMethod;
  final String orderTime;
  final int itemCount;
  final String address;
  final String status;

  OrderEntity({
    required this.id,
    required this.userName,
    required this.total,
    required this.paymentMethod,
    required this.orderTime,
    required this.itemCount,
    required this.address,
    required this.status,
  });
}
    // {
    //         "id": 7,
    //         "user_name": "Ahmed Omran",
    //         "total": "1080.00",
    //         "payment_method": "cash",
    //         "order_time": "02/03/2026 - 04:02 م",
    //         "item_count": 1,
    //         "address": "eee eee 12, Building 12, Apartment 22, مدينة نصر, القاهرة",
    //         "status": "pending"
    //     },