import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/orders_provider.dart';
import 'custom_order_tab_widget.dart';

class ListOrderTabsWidget extends StatelessWidget {
  const ListOrderTabsWidget({super.key, this.isHome = false});
  final bool isHome;
  @override
  Widget build(BuildContext context) {
    final OrdersProvider ordersProvider = Provider.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < ordersProvider.tabs.length; i++) ...[
            if (i > 0) SizedBox(width: 1.w),
            CustomOrderTabWidget(tab: ordersProvider.tabs[i], isHome: isHome),
          ],
        ],
      ),
    );
  }
}
