import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class StatsCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final String icon;
  final Color iconColor;
  final List<Map<String, String>> stats;

  const StatsCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(1.h),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(
                  icon,
                  width: 2.5.h,
                  height: 2.5.h,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
              ),
              SizedBox(width: 1.5.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),

          // Main value
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2196F3),
            ),
          ),
          SizedBox(height: 2.h),

          // Stats
          ...stats.map(
            (stat) => Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    stat['label']!,
                    style: TextStyle(fontSize: 8.sp, color: Colors.black54),
                  ),
                  Text(
                    stat['value']!,
                    style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
