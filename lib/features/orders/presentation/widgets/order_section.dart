import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'list_order_tabs_widget.dart';
import 'order_card_widget.dart';

class OrderSection extends StatelessWidget {
  const OrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order List',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            // Tabs
            const ListOrderTabsWidget(),
          ],
        ),
        SizedBox(height: 4.h),
        // Order Cards
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2.w,
            mainAxisSpacing: 2.h,
            childAspectRatio: 1.15,
          ),
          itemCount: 3,
          itemBuilder: (context, index) {
            return const OrderCardWidget();
          },
        ),
      ],
    );
  }
}
