import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_styles.dart';
import '../../../../core/helper_function/convert.dart';
import '../../../../core/widgets/price_widget.dart';

class PaymentPriceWidget extends StatelessWidget {
  const PaymentPriceWidget({
    super.key,
    required this.title,
    required this.price,
    this.isGreen = false,
    this.fontSize,
  });
  final String title;
  final String price;
  final bool isGreen;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyleClass.normalStyle().copyWith(
            fontSize: 13.sp,
            fontWeight: isGreen ? FontWeight.w900 : FontWeight.normal,
            color: isGreen ? Colors.green : Colors.black,
          ),
        ),
        PriceWidget(price: convertDataToNum(price) ?? 5555, isGreen: isGreen),
      ],
    );
  }
}
