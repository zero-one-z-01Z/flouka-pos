import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/orders_provider.dart';

class CustomOrderTabWidget extends StatelessWidget {
  const CustomOrderTabWidget({super.key, required this.tab, required this.isHome});
  final bool isHome;
  final String tab;

  @override
  Widget build(BuildContext context) {
    final OrdersProvider ordersProvider = Provider.of(context);
    final isSelected = ordersProvider.selectedTab == tab;
    return GestureDetector(
      onTap: () {
        ordersProvider.changeSelectedTab(tab,isHome: isHome);
      },
      child: Text(
        tab,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? const Color(0xFF2196F3) : Colors.black54,
        ),
      ),
    );
  }
}
