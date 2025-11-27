import 'package:flouka_pos/core/constants/app_images.dart';
import 'package:flouka_pos/core/widgets/svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../domain/entity/stats_card_entity.dart';

class StatsCardWidget extends StatelessWidget {
  final StatsCardEntity entity;

  const StatsCardWidget({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffe3ebee), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            children: [
              const SvgWidget(svg: Images.products),
              SizedBox(width: .5.w),
              Text(
                entity.title,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Text(
                entity.value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2196F3),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),

          // Main value
          SizedBox(height: 2.h),
          // Stats
          ...entity.stats.map(
            (stat) => Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(stat.label, style: TextStyle(fontSize: 10.sp)),
                  Text(
                    stat.value,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff737f84),
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
