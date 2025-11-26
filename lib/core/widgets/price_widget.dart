import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../config/app_styles.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key, required this.price, this.fontSize});
  final num price;
  final double? fontSize;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          r"$",
          style: TextStyleClass.normalStyle().copyWith(
            fontWeight: FontWeight.w900,
            fontSize: fontSize ?? 18.sp,
            color: fontSize == 15.99.sp ? Colors.green : Colors.black,
          ),
        ),
        Text(
          price.toString(),
          style: TextStyleClass.normalStyle().copyWith(
            fontWeight: FontWeight.w900,
            fontSize: fontSize ?? 18.sp,
            color: fontSize == 15.99.sp ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }
}
