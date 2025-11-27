import 'package:flouka_pos/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12.w,
      padding: EdgeInsets.only(bottom: 4.h, left: 1.w, right: 1.w),
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          Container(
            decoration: const BoxDecoration(color: Color(0xfff8f7fa)),
            child: Image.asset(Images.macBook, fit: BoxFit.cover),
          ),
          SizedBox(height: 1.h),
          SizedBox(
            width: 8.w,
            child: Text(
              "Apple 13” Macbook Pro",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Text(
                "1200 EGP",
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 1.w),
              Text(
                "1500 EGP",
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.tertiaryColor,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: Colors.amber),
              Text(
                "4.5",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
