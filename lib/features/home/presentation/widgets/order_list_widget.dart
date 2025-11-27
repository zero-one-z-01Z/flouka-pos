import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../orders/presentation/widgets/list_order_tabs_widget.dart';
import '../../../orders/presentation/widgets/order_card_widget.dart';

class OrderListWidget extends StatelessWidget {
  const OrderListWidget({super.key});

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
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            // Tabs
            const ListOrderTabsWidget(),
          ],
        ),
        SizedBox(height: 2.h),
        // Order Cards
        Row(
          spacing: 2.w,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(child: OrderCardWidget()),
            const Expanded(child: OrderCardWidget()),
            const Expanded(child: OrderCardWidget()),
          ],
        ),
      ],
    );
  }
}
