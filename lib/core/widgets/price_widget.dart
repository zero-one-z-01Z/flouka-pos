import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../config/app_styles.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.price,
    required this.isGreen,
    this.isBold = false,
  });
  final num price;
  final bool isGreen;
  final bool? isBold;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          r"$",
          style: TextStyleClass.normalStyle().copyWith(
            // fontWeight: FontWeight.w900,
            color: isGreen ? Colors.green : Colors.black,
            fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
            fontSize: 13.sp,
          ),
        ),
        Text(
          price.toString(),
          style: TextStyleClass.normalStyle().copyWith(
            // fontWeight: FontWeight.w900,
            fontSize: 13.sp,
            color: isGreen ? Colors.green : Colors.black,
            fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
