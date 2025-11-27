import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/widgets/button_widget.dart';

class OrderDetailsHeader extends StatelessWidget {
  const OrderDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Details",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "ORDER ID : 2342342",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: ButtonWidget(
            color: const Color(0xff00920a),
            borderRadius: 8,
            height: 6.h,
            onTap: () {},
            text: "Accept",
          ),
        ),
        SizedBox(width: 1.5.w),
        Expanded(
          child: ButtonWidget(
            color: const Color(0xffa90003),
            borderRadius: 8,
            height: 6.h,
            onTap: () {},
            text: "Accept",
          ),
        ),
      ],
    );
  }
}
