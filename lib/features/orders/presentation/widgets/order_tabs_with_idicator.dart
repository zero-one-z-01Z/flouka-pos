import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_styles.dart';
import '../providers/orders_provider.dart';

class CustomOrderTabsWidget extends StatelessWidget {
  const CustomOrderTabsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final OrdersProvider orderProvider = Provider.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              3,
              (index) => GestureDetector(
                onTap: () {
                  orderProvider.changeIndex(index);
                },
                child: Center(
                  child: Text(
                    orderProvider.orederTypes[index],
                    style: TextStyleClass.smallStyle().copyWith(fontSize: 12.sp),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          alignment: orderProvider.getAlignment(),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: 1.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xffdddddd),
          ),
          child: Container(
            height: 1.h,
            width: 25.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColor.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
