import 'package:flouka_pos/core/helper_function/convert.dart';
import 'package:flouka_pos/features/vendor_stores/data/models/store_model.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    super.name,
    super.phone,
    super.email,
    super.logo,
    super.cover,
    super.bio,
    super.active,
    super.otp,
    super.otpExpiredAt,
    super.productsCount,
    super.ordersCount,
    super.vendorStatistics,
    super.openDate,
    super.accountType,
    super.frontIdCard,
    super.backIdCard,
    super.nationalId,
    super.address,
    super.bankNumber,
    super.adminName,
    super.adminPhone,
    super.businessLicense,
    super.token,
    super.storeEntity,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    StoreModel? storeModel;
    if(json.containsKey('store')&&json['store']!=null){
      storeModel = StoreModel.fromJson(json['store']);
    }
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      logo: json['logo'],
      cover: json['cover'],
      bio: json['bio'],
      active: convertDataToBool(json['active']),
      otp: json['otp'],
      otpExpiredAt: json['otp_expired_at'],
      productsCount: json['products_count'],
      ordersCount: json['orders_count'],
      openDate: json['open_date'],
      accountType: json['account_type'],
      frontIdCard: json['front_id_card'],
      backIdCard: json['back_id_card'],
      nationalId: json['national_id'],
      address: json['address'],
      bankNumber: json['bank_number'],
      adminName: json['admin_name'],
      adminPhone: json['admin_phone'],
      vendorStatistics: json['statistics'] != null
          ? VendorStatisticsModel.fromJson(json['statistics'])
          : null,
      businessLicense: json['business_license'],
      token: json['token'],
      storeEntity: storeModel,
    );
  }
}

class VendorStatisticsModel extends VendorStatisticsEntity {
  const VendorStatisticsModel({
    super.orders,
    super.sales,
    super.products,
  });

  factory VendorStatisticsModel.fromJson(Map<String, dynamic> json) {
    return VendorStatisticsModel(
      orders: json['orders'] != null
          ? OrdersStatisticsModel.fromJson(json['orders'])
          : null,
      sales: json['sales'] != null
          ? SalesStatisticsModel.fromJson(json['sales'])
          : null,
      products: json['products'] != null
          ? ProductsStatisticsModel.fromJson(json['products'])
          : null,
    );
  }
}

class OrdersStatisticsModel extends OrdersStatisticsEntity {
  const OrdersStatisticsModel({
    super.total,
    super.active,
    super.completed,
    super.cancelled,
  });

  factory OrdersStatisticsModel.fromJson(Map<String, dynamic> json) {
    return OrdersStatisticsModel(
      total: json['total'],
      active: json['active'],
      completed: json['completed'],
      cancelled: json['cancelled'],
    );
  }
}

class SalesStatisticsModel extends SalesStatisticsEntity {
  const SalesStatisticsModel({
    super.total,
    super.thisMonth,
    super.lastMonth,
  });

  factory SalesStatisticsModel.fromJson(Map<String, dynamic> json) {
    return SalesStatisticsModel(
      total: json['total'],
      thisMonth: json['this_month'],
      lastMonth: json['last_month'],
    );
  }
}

class ProductsStatisticsModel extends ProductsStatisticsEntity {
  const ProductsStatisticsModel({
    super.best,
    super.worst,
  });

  factory ProductsStatisticsModel.fromJson(Map<String, dynamic> json) {
    return ProductsStatisticsModel(
      best: json['best'] !=null ? json['best']['name'] : null,
      worst: json['worst'] !=null ? json['worst']['name'] : null,
    );
  }
}