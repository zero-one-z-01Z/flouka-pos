import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../core/config/app_styles.dart';
import '../../../../../../core/constants/app_images.dart';
import '../../../../language/presentation/provider/language_provider.dart';

class PerformanceTab extends StatelessWidget {
  const PerformanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(2.w),
      child: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
              child: Text(
                LanguageProvider.translate('global', 'product_performance'),
                style: TextStyleClass.smallStyle().copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff111827),
                ),
              ),
            ),
            SizedBox(height: 1.h),
            _buildFilters(),
            SizedBox(height: 3.h),
            _buildTableHeader(),
            SizedBox(height: 1.h),
            _buildProductList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Wrap(
      spacing: 1.w,
      runSpacing: 1.h,
      children: [
        _buildFilterChip(
          icon: Icons.calendar_today_outlined,
          label: LanguageProvider.translate('global', 'last_30_days'),
        ),
        _buildFilterChip(
          icon: Icons.grid_view,
          label: LanguageProvider.translate('global', 'all_categories'),
        ),
        _buildFilterChip(
          icon: Icons.sort,
          label: LanguageProvider.translate('global', 'sort_revenue'),
        ),
        _buildFilterChip(
          icon: Icons.info_outline,
          label: LanguageProvider.translate('global', 'status_all'),
        ),
      ],
    );
  }

  Widget _buildFilterChip({required IconData icon, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 1.2.h),
      decoration: BoxDecoration(
        color: const Color(0xffF3F4F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.sp, color: const Color(0xff6B7280)),
          SizedBox(width: 0.8.w),
          Text(
            label,
            style: TextStyleClass.smallStyle().copyWith(
              fontSize: 10.sp,
              color: const Color(0xff374151),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: const Color(0xffF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _tableCell('Image', flex: 1),
          _tableCell(LanguageProvider.translate('global', 'product_name'), flex: 3),
          _tableCell(LanguageProvider.translate('global', 'sold_qty'), flex: 1),
          _tableCell(LanguageProvider.translate('global', 'revenue'), flex: 1.2),
          _tableCell(
            LanguageProvider.translate('global', 'profit_percent'),
            flex: 1.2,
          ),
          _tableCell(LanguageProvider.translate('global', 'status'), flex: 1.5),
        ],
      ),
    );
  }

  Widget _tableCell(String text, {required double flex, bool isHeader = true}) {
    return Expanded(
      flex: (flex * 10).toInt(),
      child: Text(
        text,
        textAlign: isHeader && flex == 1 ? TextAlign.center : TextAlign.start,
        style: TextStyleClass.smallStyle().copyWith(
          fontSize: 10.sp,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? const Color(0xff6B7280) : const Color(0xff374151),
        ),
      ),
    );
  }

  Widget _buildProductList() {
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
        return _buildProductRow(product);
      },
    );
  }

  Widget _buildProductRow(Map<String, dynamic> product) {
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
  }
}
