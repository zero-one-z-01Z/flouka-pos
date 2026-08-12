import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        ordersProvider.changeSelectedTab(tab, isHome: isHome);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 1.2.w, vertical: 0.8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.selectedRowTint : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColor.gold.withValues(alpha: 0.55) : AppColor.hairline,
          ),
        ),
        child: Text(
          tab,
          style: GoogleFonts.lato(
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? AppColor.ink : AppColor.textMuted,
          ),
        ),
      ),
    );
  }
}
