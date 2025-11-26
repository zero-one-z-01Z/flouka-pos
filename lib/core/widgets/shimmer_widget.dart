import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key, required this.width,this.numOfShimmer, required this.height, this.radius, this.padding});
  final double width,height;
  final double? radius;
  final EdgeInsets? padding;
  final int? numOfShimmer ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.h),
      child: Wrap(
        runSpacing: 1.h,
        spacing: 2.w,
        children: List.generate(numOfShimmer??1, (index) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius??6)),
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade200,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(radius??6)),
                  color: Colors.white),
            ),
          ),
        ),),
      ),
    );
  }
}