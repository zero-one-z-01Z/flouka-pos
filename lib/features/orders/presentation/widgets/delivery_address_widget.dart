import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_styles.dart';
import '../../../language/presentation/provider/language_provider.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({super.key});
  @override
  Widget build(BuildContext context) {
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
            "26 amna hafiz /street 23/door 24 alexandria sidegaber el mosher tantaimow",
            style: TextStyleClass.smallStyle().copyWith(
              color: const Color(0xff535353),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 4.w),
          Row(
            spacing: 2.w,
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
                "+2010981234234",
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
