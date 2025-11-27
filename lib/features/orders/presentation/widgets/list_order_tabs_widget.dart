import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/orders_provider.dart';
import 'custom_order_tab_widget.dart';

class ListOrderTabsWidget extends StatelessWidget {
  const ListOrderTabsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final OrdersProvider ordersProvider = Provider.of(context);

    return Row(
      spacing: 2.w,
      children: List.generate(
        ordersProvider.tabs.length,
        (index) => CustomOrderTabWidget(tab: ordersProvider.tabs[index]),
      ),
    );
  }
}
