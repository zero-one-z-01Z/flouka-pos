import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/performance_filter_row_widget.dart';
import '../../widgets/performance_header_widget.dart';
import '../../widgets/performance_product_list_widget.dart';
import '../../widgets/performance_table_header_widget.dart';

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
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PerformanceHeaderWidget(),
            SizedBox(height: 1),
            PerformanceFilterRowWidget(),
            SizedBox(height: 24), // 3.h equivalent approximately
            PerformanceTableHeaderWidget(),
            SizedBox(height: 8), // 1.h equivalent approximately
            PerformanceProductListWidget(),
          ],
        ),
      ),
    );
  }
}
