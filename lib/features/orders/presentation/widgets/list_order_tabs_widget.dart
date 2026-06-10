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

    return Row(mainAxisAlignment: MainAxisAlignment.center,
      spacing: 2.w,
      children: List.generate(
        ordersProvider.tabs.length,
        (index) => CustomOrderTabWidget(tab: ordersProvider.tabs[index],isHome: isHome,),
      ),
    );
  }
}
