import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/custom_star_rating_widget.dart';
import '../../../../core/widgets/price_widget.dart';
import '../../domain/entity/order_entity.dart';

class OrderDetailsItemWidget extends StatelessWidget {
  const OrderDetailsItemWidget({super.key, required this.item});
  final OrderItemEntity item;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.w,
      padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h, bottom: 3.h),
      decoration: BoxDecoration(
        color: const Color(0xfff3f3f3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Images.macBook, width: 8.w),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              spacing: 1.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product?.title??"",
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
                    PriceWidget(price: item.price!, isGreen: false, isBold: true),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomStarRatingWidget(itemSize: 11.sp, rate: item.product!.rate!),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              item.product?.rate.toString()??"",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyleClass.smallStyle(
                                color: Colors.grey,
                              ).copyWith(fontSize: 10.sp),
                            ),
                          ),
                        ],
                      ),
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
