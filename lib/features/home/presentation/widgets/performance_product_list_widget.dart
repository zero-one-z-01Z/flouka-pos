import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../language/presentation/provider/language_provider.dart';

class PerformanceProductListWidget extends StatelessWidget {
  const PerformanceProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        'name': 'iPhone 14 Pro Max',
        'qty': 120,
        'revenue': '240,000 \$',
        'profit': '+32%',
        'profitColor': const Color(0xff10B981),
        'status': LanguageProvider.translate('global', 'bestseller'),
        'statusColor': const Color(0xffD1FAE5),
        'statusTextColor': const Color(0xff047857),
      },
      {
        'name': 'Samsung Galaxy S23',
        'qty': 54,
        'revenue': '97,200 \$',
        'profit': '+12%',
        'profitColor': const Color(0xff10B981),
        'status': LanguageProvider.translate('global', 'active'),
        'statusColor': const Color(0xffDBEAFE),
        'statusTextColor': const Color(0xff1D4ED8),
      },
      {
        'name': 'Xiaomi Redmi Note 12',
        'qty': 6,
        'revenue': '8,400 \$',
        'profit': '-8%',
        'profitColor': const Color(0xffEF4444),
        'status': LanguageProvider.translate('global', 'low_sales'),
        'statusColor': const Color(0xffFEE2E2),
        'statusTextColor': const Color(0xffB91C1C),
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      separatorBuilder: (context, index) =>
          Divider(color: Colors.grey.withOpacity(0.1), height: 1),
      itemBuilder: (context, index) {
        final product = products[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          child: Row(
            children: [
              Expanded(
                flex: 10,
                child: Center(
                  child: Container(
                    width: 4.w,
                    height: 4.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage(Images.macBook),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 30,
                child: Text(
                  product['name'],
                  style: TextStyleClass.smallStyle().copyWith(
                    fontSize: 11.sp,
                    color: const Color(0xff111827),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: Text(
                  '${product['qty']}',
                  style: TextStyleClass.smallStyle().copyWith(
                    fontSize: 10.sp,
                    color: const Color(0xff4B5563),
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: Text(
                  product['revenue'],
                  style: TextStyleClass.smallStyle().copyWith(
                    fontSize: 10.sp,
                    color: const Color(0xff111827),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: Text(
                  product['profit'],
                  style: TextStyleClass.smallStyle().copyWith(
                    fontSize: 10.sp,
                    color: product['profitColor'],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 15,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: product['statusColor'],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        product['status'],
                        style: TextStyleClass.smallStyle().copyWith(
                          fontSize: 9.sp,
                          color: product['statusTextColor'],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
