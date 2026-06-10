import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ShimmerMessageWidget extends StatelessWidget {

  const ShimmerMessageWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:2.w),
      child: Column(
        children: List.generate(2, (index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: Row(
            mainAxisAlignment: index.isEven?MainAxisAlignment.end:MainAxisAlignment.start,
            children: [
              // Shimmer.fromColors(
              //   baseColor: Colors.grey.shade300,
              //   highlightColor: Colors.grey.shade200,
              //   child: Container(
              //     width: 40.w,
              //     height: 5.h,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),),
      ),
    );
  }
}
