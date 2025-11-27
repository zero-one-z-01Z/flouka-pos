import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/custom_star_rating_widget.dart';
import '../../../../core/widgets/price_widget.dart';

class OrderDetailsItemWidget extends StatelessWidget {
  const OrderDetailsItemWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h, bottom: 3.h),
      decoration: BoxDecoration(
        color: const Color(0xfff3f3f3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Images.macBook),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              spacing: 1.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lenovo Yoga 920 13/Core i7/16GB/SSD 1TB",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyleClass.smallStyle()
                      .copyWith(color: const Color(0xff333542))
                      .copyWith(fontSize: 13.sp),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 4,
                  children: [
                    const PriceWidget(price: 999, isGreen: false, isBold: true),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CustomStarRatingWidget(),
                        Text(
                          "153,254",
                          style: TextStyleClass.smallStyle(
                            color: Colors.grey,
                          ).copyWith(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
