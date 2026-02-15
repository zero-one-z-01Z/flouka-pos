import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SoldByProductContainerWidget extends StatelessWidget {
  const SoldByProductContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20.sp);

    return Stack(
      children: [
        // Main white container
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sold by",
                        style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        "Apple Store",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < 4 ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(Icons.favorite_border, size: 16.sp, color: Colors.grey),
                      SizedBox(width: 2.w),
                      Icon(Icons.shopping_cart_outlined, size: 16.sp, color: Colors.grey),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),

        // Bottom gradient
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: borderRadius.bottomLeft,
              bottomRight: borderRadius.bottomRight,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.primaryColor, Colors.lightBlueAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ),

        // Left gradient side
        Positioned(
          left: 0,
          top: 0,
          bottom: 3, // exclude bottom border
          width: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: borderRadius.topLeft,
              bottomLeft: borderRadius.bottomLeft,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.lightBlueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ),

        // Right gradient side
        Positioned(
          right: 0,
          top: 0,
          bottom: 3, // exclude bottom border
          width: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: borderRadius.topRight,
              bottomRight: borderRadius.bottomRight,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.lightBlueAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
