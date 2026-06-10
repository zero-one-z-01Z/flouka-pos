class UserEntity {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? logo;
  final String? cover;
  final String? bio;
  bool? active;
  final String? otp;
  final String? otpExpiredAt;
  final int? productsCount;
  final int? ordersCount;
  final String? openDate;
  final String? accountType;
  final String? frontIdCard;
  final String? backIdCard;
  final String? nationalId;
  final String? address;
  final String? bankNumber;
  final String? adminName;
  final String? adminPhone;
  final String? businessLicense;
  final String? token;
  final VendorStatisticsEntity? vendorStatistics;

  UserEntity({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.logo,
    this.cover,
    this.bio,
    this.active,
    this.otp,
    this.otpExpiredAt,
    this.productsCount,
    this.ordersCount,
    this.openDate,
    this.vendorStatistics,
    this.accountType,
    this.frontIdCard,
    this.backIdCard,
    this.nationalId,
    this.address,
    this.bankNumber,
    this.adminName,
    this.adminPhone,
    this.businessLicense,
    this.token,
  });
}

class VendorStatisticsEntity {
  final OrdersStatisticsEntity? orders;
  final SalesStatisticsEntity? sales;
  final ProductsStatisticsEntity? products;

  const VendorStatisticsEntity({
    this.orders,
    this.sales,
    this.products,
  });
}

class OrdersStatisticsEntity {
  final int? total;
  final int? active;
  final int? completed;
  final int? cancelled;

  const OrdersStatisticsEntity({
    this.total,
    this.active,
    this.completed,
    this.cancelled,
  });
}

class SalesStatisticsEntity {
  final num? total;
  final num? thisMonth;
  final num? lastMonth;

  const SalesStatisticsEntity({
    this.total,
    this.thisMonth,
    this.lastMonth,
  });
}

class ProductsStatisticsEntity {
  final String? best;
  final String? worst;

  const ProductsStatisticsEntity({
    this.best,
    this.worst,
  });
}
