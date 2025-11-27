import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/widgets/custom_star_rating_widget.dart';
import '../../../../core/widgets/price_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';

class OrderDetailsItemWidget extends StatelessWidget {
  const OrderDetailsItemWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h, bottom: 3.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LanguageProvider.translate("global", "Item Summary"),
                  style: TextStyleClass.normalStyle(),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColor.primaryColor,
                  size: 16,
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                width: 20.w,
                imageUrl: "https://placehold.co/600x400",
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  spacing: 1.h,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Lenovo Yoga 920 13/Core i7/16GB/SSD 1TB",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyleClass.normalStyle().copyWith(
                        color: const Color(0xff333542),
                      ),
                    ),
                    Row(
                      spacing: 4,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const PriceWidget(price: 999),
                        const Spacer(),
                        const CustomStarRatingWidget(),
                        Text(
                          "153,254",
                          style: TextStyleClass.smallStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
