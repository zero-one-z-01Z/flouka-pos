import '../../../../core/helper_function/convert.dart';
import '../../domain/entity/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({required super.id, required super.userId, required super.subTotal,
    required super.tax, required super.delivery, required super.discount,
    required super.deliveryPrice, required super.total, required super.addressId,
    required super.paymentMethod, required super.status, required super.createdAt,
    required super.user, required super.address, required super.vendorOrders});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      subTotal: convertDataToNum(json['sub_total'])!,
      tax: convertDataToNum(json['tax'])!,
      delivery:convertDataToNum(json['delivery'])!,
      discount: convertDataToNum(json['discount']),
      deliveryPrice:convertDataToNum(json['delivery_price'])!,
      total:convertDataToNum(json['total'])!,
      addressId: json['address_id'],
      paymentMethod: json['payment_method'],
      status: OrderStatus.getFromString(json['status']),
      createdAt: json['created_at'],
      address: AddressModel.fromJson(json['address']),
      user: OrderUserModel.fromJson(json['user']),
      vendorOrders: VendorOrderModel.fromJson(json['vendor_order']),
    );
  }
}

class OrderUserModel extends OrderUser {
  OrderUserModel({
    required super.id,
    required super.name,
    required super.image,
    required super.phone, required super.fullPhone,
  });

  factory OrderUserModel.fromJson(Map<String, dynamic> json) {
    return OrderUserModel(
      id: json['id'],
      name: json['name']??"",
      image: json['image'],
      phone: json['phone']??"", fullPhone: json['full_phone'],
    );
  }
}


class AddressModel extends AddressEntity {
  AddressModel({ required super.id, required super.areaId, required super.userId,
    required super.lat, required super.lng, required super.name, required super.address,
    required super.phone, required super.isDefault, required super.area, required super.city});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      areaId: json['area_id'],
      userId: json['user_id'],
      lat: convertDataToNum(json['lat'])!,
      lng: convertDataToNum(json['lng'])!,
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      isDefault: json['default'],
      area: AreaModel.fromJson(json['area']),
      city: CityModel.fromJson(json['city']),
    );
  }
}

class AreaModel extends AreaEntity {
  AreaModel({required super.id, required super.cityId, required super.name,});

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      id: json['id'],
      cityId: json['city_id'],
      name: json['name'],
    );
  }
}

class CityModel extends CityEntity {
  CityModel({
    required super.id,
    required super.name,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class VendorOrderModel extends VendorOrderEntity {
  VendorOrderModel({
    required super.id,
    required super.status,
    required super.subTotal,
    required super.tax,
    required super.discount,
    required super.deliveryPrice,
    required super.total,
    super.items,
  });

  factory VendorOrderModel.fromJson(Map<String, dynamic> json) {
    List<OrderItemModel> items = [];
    if (json['items'] != null) {
      items = List<OrderItemModel>.from(
        json['items'].map((x) => OrderItemModel.fromJson(x)),
      );
    }
    return VendorOrderModel(
      id: json['id'],
      status: VendorOrderStatus.getFromString(json['status']),
      subTotal: convertDataToNum(json['sub_total'])!,
      tax: convertDataToNum(json['tax'])!,
      discount:convertDataToNum(json['discount'])!,
      deliveryPrice:convertDataToNum(json['delivery_price'])!,
      total:convertDataToNum(json['total'])!,
      items: items,
    );
  }
}

class OrderItemModel extends OrderItemEntity {
  OrderItemModel({
    super.id,
    super.productId,
    super.storeId,
    super.product,
    super.variant,
    super.productVariantId,
    super.changeableQuantity,
    super.quantity,
    super.afterQuantity,
    super.price,
    super.status,
    super.attributes,
    super.canReviewProduct,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      productId: json['product_id'],
      storeId: json['store_id'],
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
      variant: json['variant'] != null
          ? OrderVariantModel.fromJson(json['variant'])
          : null,
      productVariantId: json['product_variant_id'],
      quantity: json['quantity'],
      afterQuantity: json['after_quantity'],
      price: (json['price'] as num?)?.toDouble(),
      status: OrderItemStatus.getFromString(json['status']),
      changeableQuantity: json['quantity'],
      attributes: json['attributes'],
      canReviewProduct: json['can_review_product'],
    );
  }
}

class ProductModel extends ProductEntity {
  ProductModel({
    super.id,
    super.vendorId,
    super.title,
    super.description,
    super.brandId,
    super.categoryId,
    super.rate,
    super.reviewsCount,
    super.price,
    super.offerPrice,
    super.costPrice,
    super.ordersCount,
    super.sku,
    super.finalPrice,
    super.discountPercentage,
    super.image,
    super.isFavorite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      vendorId: json['vendor_id'],
      title: json['title'],
      description: json['description'],
      brandId: json['brand_id'],
      categoryId: json['category_id'],
      rate: (json['rate'] as num?)?.toDouble(),
      reviewsCount: json['reviews_count'],
      price: (json['price'] as num?)?.toDouble(),
      offerPrice: (json['offer_price'] as num?)?.toDouble(),
      costPrice: (json['cost_price'] as num?)?.toDouble(),
      ordersCount: json['orders_count'],
      sku: json['sku'],
      finalPrice: (json['final_price'] as num?)?.toDouble(),
      discountPercentage: convertDataToDouble(json['discount_percentage']),
      image: json['image'],
      isFavorite: json['is_favorite'],
    );
  }
}

class OrderVariantModel extends OrderVariantEntity {
  OrderVariantModel({
    super.id,
    super.productId,
    super.name,
    super.sku,
    super.price,
    super.offerPrice,
    super.finalPrice,
  });

  factory OrderVariantModel.fromJson(Map<String, dynamic> json) {
    return OrderVariantModel(
      id: json['id'],
      productId: json['product_id'],
      name: json['name'],
      sku: json['sku'],
      price: (json['price'] as num?)?.toDouble(),
      offerPrice: (json['offer_price'] as num?)?.toDouble(),
      finalPrice: (json['final_price'] as num?)?.toDouble(),
    );
  }
}