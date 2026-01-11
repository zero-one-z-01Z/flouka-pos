import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/custom_star_rating_widget.dart';
import '../../../../core/widgets/price_widget.dart';

class UpdateOrderWiidget extends StatelessWidget {
  const UpdateOrderWiidget({super.key, required this.isRemove});
  final bool isRemove;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 41.w,
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
            flex: 2,
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
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomStarRatingWidget(itemSize: 11.sp),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              "153,254",
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
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: ButtonWidget(
              takeSmallestWidth: true,
              color: isRemove ? const Color(0xffDF0033) : const Color(0xff00920A),
              width: 7.w,
              height: 4.h,
              onTap: () {},
              text: isRemove
                  ? LanguageProvider.translate('buttons', 'remove')
                  : LanguageProvider.translate('buttons', 'reset'),
            ),
          ),
        ],
      ),
    );
  }
}
