import 'package:flouka_pos/core/constants/constants.dart';
import 'package:provider/provider.dart';

import '../../../products/domain/entity/product_entity.dart';
import '../../../products/domain/entity/variant_entity.dart';
import '../../presentation/providers/order_details_provider.dart';
import 'order_entity.dart';
import 'package:flutter/material.dart';

class OrderEntity {
  final int id;
  final int userId;
  final num subTotal;
  final num tax;
  final num delivery;
  final num? discount;
  final num deliveryPrice;
  final num total;
  final int addressId;
  final String paymentMethod;
  OrderStatus status;
  final String createdAt;
  final AddressEntity address;
  final OrderUser? user;
  final VendorOrderEntity vendorOrders;

  OrderEntity({
    required this.id,
    required this.userId,
    required this.subTotal,
    required this.tax,
    required this.delivery,
    required this.discount,
    required this.deliveryPrice,
    required this.total,
    required this.addressId,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
    required this.user,
    required this.address,
    required this.vendorOrders,
  });
}

class OrderUser{
  final int id;
  final String name;
  final String image;
  final String phone;
  OrderUser({
    required this.id,
    required this.name,
    required this.image,
    required this.phone,
  });

}

enum OrderStatus {
  pendingPayment({
    "text": "pending_payment",
    "title": "pending_payment_title",
    "des": "pending_payment_des",
    "color": Color(0xffE9A90A),
    "details_color": Color(0xffE9A90A),
    // "image": AppImages.settingsOrders,
    "level": 1,
  }),
  paid({
    "text": "paid",
    "title": "paid_title",
    "des": "paid_des",
    "color": Colors.green,
    "details_color": Colors.green,
    "level": 2,
  }),
  paymentFailed({
    "text": "payment_failed",
    "title": "payment_failed_title",
    "des": "payment_failed_des",
    "color": Color(0xffB03329),
    "details_color": Color(0xffB03329),
    "level": 2,
  }),
  processing({
    "text": "processing",
    "title": "processing_title",
    "des": "processing_des",
    "color": Color(0xff2D40AC),
    "details_color": Color(0xff2D40AC),
    "level": 4,
  }),
  needsUserAction({
    "text": "needs_user_action",
    "title": "needs_user_action_title",
    "des": "needs_user_action_des",
    "color": Color(0xffE9A90A),
    "details_color": Color(0xffE9A90A),
    "level": 5,
  }),
  partiallyFulfilled({
    "text": "partially_fulfilled",
    "title": "partially_fulfilled_title",
    "des": "partially_fulfilled_des",
    "color": Color(0xff2D40AC),
    "details_color": Color(0xff2D40AC),
    "level": 7,
  }),
  fulfilled({
    "text": "fulfilled",
    "title": "fulfilled_title",
    "des": "fulfilled_des",
    "color": Colors.green,
    "details_color": Colors.green,
    "level": 10,
  }),
  cancelled({
    "text": "cancelled",
    "title": "cancelled_title",
    "des": "cancelled_des",
    "color": Color(0xffB03329),
    "details_color": Color(0xffB03329),
    "level": 10,
  }),
  refunded({
    "text": "refunded",
    "title": "refunded_title",
    "des": "refunded_des",
    "color": Color(0xff7D7D7D),
    "details_color": Color(0xff7D7D7D),
    "level": 10,
  });

  final Map<String, dynamic> info;

  const OrderStatus(this.info);

  static OrderStatus getFromString(String? text) {
    return OrderStatus.values.firstWhere(
          (element) => element.info["text"] == text,
      orElse: () => OrderStatus.pendingPayment,
    );
  }

  String get text => info["text"];

  num get level => info["level"];

  String? get image => info["image"];

  String get title => info["title"];

  String get des => info["des"];

  Color get color => info["color"];

  Color get detailsColor => info["details_color"];

  bool get isCompleted => this == OrderStatus.fulfilled || this == OrderStatus.refunded || this == OrderStatus.cancelled ;

  bool get isProcessing => this == OrderStatus.processing || this == OrderStatus.needsUserAction ;

  bool get isNew => this == OrderStatus.pendingPayment || this == OrderStatus.paid || this == OrderStatus.paymentFailed ;

}

class AddressEntity {
  final int id;
  final int areaId;
  final int userId;
  final num lat;
  final num lng;
  final String name;
  final String address;
  final String phone;
  final int isDefault;
  final AreaEntity area;
  final CityEntity city;

  AddressEntity({
    required this.id,
    required this.areaId,
    required this.userId,
    required this.lat,
    required this.lng,
    required this.name,
    required this.address,
    required this.phone,
    required this.isDefault,
    required this.area,
    required this.city,
  });
}

class AreaEntity {
  final int id;
  final int cityId;
  final String name;

  AreaEntity({
    required this.id,
    required this.cityId,
    required this.name,
  });
}

class CityEntity {
  final int id;
  final String name;

  CityEntity({
    required this.id,
    required this.name,
  });
}

class VendorOrderEntity {
  final int id;
  VendorOrderStatus status;
  final num subTotal;
  final num tax;
  final num discount;
  final num deliveryPrice;
  final num total;
  final List<OrderItemEntity>? items;

  VendorOrderEntity({
    required this.id,
    required this.status,
    required  this.subTotal,
    required this.tax,
    required this.discount,
    required this.deliveryPrice,
    required this.total,
    required this.items,
  });

}

enum VendorOrderStatus {
  pending({
    "text": "pending",
    "title": "pending_title",
    "des": "pending_des",
    "color": Color(0xffE9A90A),
    "details_color": Color(0xffE9A90A),
    "level": 1,
  }),

  accepted({
    "text": "accepted",
    "title": "accepted_title",
    "des": "accepted_des",
    "color": Colors.green,
    "details_color": Colors.green,
    "level": 2,
  }),

  processing({
    "text": "processing",
    "title": "processing_title",
    "des": "processing_des",
    "color": Color(0xff2D40AC),
    "details_color": Color(0xff2D40AC),
    "level": 3,
  }),

  readyToShip({
    "text": "ready_to_ship",
    "title": "ready_to_ship_title",
    "des": "ready_to_ship_des",
    "color": Color(0xff6A5ACD),
    "details_color": Color(0xff6A5ACD),
    "level": 4,
  }),

  shipped({
    "text": "shipped",
    "title": "shipped_title",
    "des": "shipped_des",
    "color": Color(0xff009688),
    "details_color": Color(0xff009688),
    "level": 5,
  }),

  delivered({
    "text": "delivered",
    "title": "delivered_title",
    "des": "delivered_des",
    "color": Colors.green,
    "details_color": Colors.green,
    "level": 6,
  }),

  partiallyCancelled({
    "text": "partially_cancelled",
    "title": "partially_cancelled_title",
    "des": "partially_cancelled_des",
    "color": Color(0xffFF9800),
    "details_color": Color(0xffFF9800),
    "level": 6,
  }),

  cancelled({
    "text": "cancelled",
    "title": "cancelled_title",
    "des": "cancelled_des",
    "color": Color(0xffB03329),
    "details_color": Color(0xffB03329),
    "level": 6,
  }),

  rejected({
    "text": "rejected",
    "title": "rejected_title",
    "des": "rejected_des",
    "color": Color(0xffB03329),
    "details_color": Color(0xffB03329),
    "level": 6,
  }),

  outOfStock({
    "text": "out_of_stock",
    "title": "out_of_stock_title",
    "des": "out_of_stock_des",
    "color": Color(0xff7D7D7D),
    "details_color": Color(0xff7D7D7D),
    "level": 6,
  });

  final Map<String, dynamic> info;

  const VendorOrderStatus(this.info);

  static VendorOrderStatus getFromString(String? text) {
    return VendorOrderStatus.values.firstWhere(
          (element) => element.info["text"] == text,
      orElse: () => VendorOrderStatus.pending,
    );
  }

  String get text => info["text"];

  num get level => info["level"];

  String? get image => info["image"];

  String get title => info["title"];

  String get des => info["des"];

  Color get color => info["color"];

  Color get detailsColor => info["details_color"];

  bool get isCancelled =>
      this == VendorOrderStatus.cancelled ||
          this == VendorOrderStatus.rejected ||
          this == VendorOrderStatus.outOfStock;

  bool get isCompleted =>
      this == VendorOrderStatus.delivered;

  bool get isActive =>
      !isCancelled &&
          this != VendorOrderStatus.delivered;
}

class OrderItemEntity {
  final int? id;
  final int? productId;
  final int? storeId;
  final ProductEntity? product;
  final OrderVariantEntity? variant;
  final int? productVariantId;
  int? quantity;
  final int? afterQuantity;
  final num? price;
  OrderItemStatus? status;
  final dynamic attributes;
  final bool? canReviewProduct;
  int? changeableQuantity;
  OrderItemEntity({
    this.id,
    this.productId,
    this.storeId,
    this.product,
    this.variant,
    this.productVariantId,
    this.quantity,
    this.afterQuantity,
    this.price,
    this.status,
    this.attributes,
    this.changeableQuantity ,
    this.canReviewProduct,
  });

  void increaseQuantity(){
    if((changeableQuantity??0) < (quantity??0)){
      changeableQuantity = (changeableQuantity??0) + 1;
    }
    Provider.of<OrderDetailsProvider>(Constants.globalContext(), listen: false).rebuild();

  }
  void decreaseQuantity(){
    if((changeableQuantity??0) >0){
      changeableQuantity = (changeableQuantity??0) - 1;
    }
    Provider.of<OrderDetailsProvider>(Constants.globalContext(), listen: false).rebuild();
  }
}

enum OrderItemStatus {
  pending({
    "text": "pending",
    "title": "pending_title",
    "des": "pending_des",
    "color": Color(0xffE9A90A),
    "details_color": Color(0xffE9A90A),
    "level": 1,
  }),
  confirmed({
    "text": "confirmed",
    "title": "confirmed_title",
    "des": "confirmed_des",
    "color": Color(0xff2D40AC),
    "details_color": Color(0xff2D40AC),
    "level": 2,
  }),
  outOfStock({
    "text": "out_of_stock",
    "title": "out_of_stock_title",
    "des": "out_of_stock_des",
    "color": Color(0xffB03329),
    "details_color": Color(0xffB03329),
    "level": 3,
  }),
  replaced({
    "text": "replaced",
    "title": "replaced_title",
    "des": "replaced_des",
    "color": Color(0xff7D7D7D),
    "details_color": Color(0xff7D7D7D),
    "level": 4,
  }),
  cancelled({
    "text": "cancelled",
    "title": "cancelled_title",
    "des": "cancelled_des",
    "color": Color(0xffB03329),
    "details_color": Color(0xffB03329),
    "level": 10,
  }),
  readyToShip({
    "text": "ready_to_ship",
    "title": "ready_to_ship_title",
    "des": "ready_to_ship_des",
    "color": Color(0xff2D40AC),
    "details_color": Color(0xff2D40AC),
    "level": 5,
  }),
  shipped({
    "text": "shipped",
    "title": "shipped_title",
    "des": "shipped_des",
    "color": Color(0xff2D40AC),
    "details_color": Color(0xff2D40AC),
    "level": 7,
  }),
  delivered({
    "text": "delivered",
    "title": "delivered_title",
    "des": "delivered_des",
    "color": Colors.green,
    "details_color": Colors.green,
    "level": 10,
  });

  final Map<String, dynamic> info;

  const OrderItemStatus(this.info);

  static OrderItemStatus getFromString(String? text) {
    return OrderItemStatus.values.firstWhere(
          (element) => element.info["text"] == text,
      orElse: () => OrderItemStatus.pending,
    );
  }

  String get text => info["text"];

  num get level => info["level"];

  String? get image => info["image"];

  String get title => info["title"];

  String get des => info["des"];

  Color get color => info["color"];

  Color get detailsColor => info["details_color"];

  bool get isCancelled =>
      this == OrderItemStatus.cancelled ||
          this == OrderItemStatus.outOfStock;
}

class ProductEntity {
  final int? id;
  final int? vendorId;
  final String? title;
  final String? description;
  final int? brandId;
  final int? categoryId;
  final num? rate;
  final int? reviewsCount;
  final num? price;
  final num? offerPrice;
  final num? costPrice;
  final int? ordersCount;
  final String? sku;
  final num? finalPrice;
  final num ? discountPercentage;
  final String? image;
  final bool? isFavorite;

  ProductEntity({
    this.id,
    this.vendorId,
    this.title,
    this.description,
    this.brandId,
    this.categoryId,
    this.rate,
    this.reviewsCount,
    this.price,
    this.offerPrice,
    this.costPrice,
    this.ordersCount,
    this.sku,
    this.finalPrice,
    this.discountPercentage,
    this.image,
    this.isFavorite,
  });
}

class OrderVariantEntity {
  final int? id;
  final int? productId;
  final String? name;
  final String? sku;
  final num? price;
  final num? offerPrice;
  final num? finalPrice;

  OrderVariantEntity({
    this.id,
    this.productId,
    this.name,
    this.sku,
    this.price,
    this.offerPrice,
    this.finalPrice,
  });
}
