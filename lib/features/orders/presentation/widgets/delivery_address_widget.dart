import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_styles.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/order_details_provider.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageProvider.translate("global", "Delivery Address"),
            style: TextStyleClass.smallStyle().copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            orderDetailsProvider.orderDetailsEntity!.address,
            style: TextStyleClass.smallStyle().copyWith(
              color: const Color(0xff535353),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            spacing: 1.w,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                LanguageProvider.translate("global", "Mobile number"),
                style: TextStyleClass.normalStyle().copyWith(
                  color: const Color(0xff595959),
                  fontSize: 13.sp,
                ),
              ),
              Text(
                orderDetailsProvider.orderDetailsEntity!.userPhone,
                style: TextStyleClass.normalStyle().copyWith(
                  color: AppColor.primaryColor,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
