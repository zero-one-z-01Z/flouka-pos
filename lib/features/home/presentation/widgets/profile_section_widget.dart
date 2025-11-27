import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w, bottom: 17.5.h),
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: -5,
            offset: Offset(0, 6),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Column(
        children: [
          // Profile Image
          CircleAvatar(
            radius: 5.h,
            backgroundColor: const Color(0xFFE0E0E0),
            child: Icon(Icons.person, size: 5.h, color: Colors.white),
          ),
          SizedBox(height: 1.5.h),

          // Name
          Text(
            'Moaz Mohamed',
            style: TextStyleClass.smallStyle().copyWith(fontSize: 12.sp),
          ),
          SizedBox(height: 0.5.h),

          // Username
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Username: mazo.fayd',
                style: TextStyle(fontSize: 10.sp, color: Colors.black54),
              ),
            ],
          ),
          SizedBox(height: 4.h),

          // Store Status
          Text(
            'Store Status',
            style: TextStyleClass.smallStyle().copyWith(fontSize: 10.sp),
          ),
          SizedBox(height: 1.h),

          // Active Status Button
          Container(
            padding: EdgeInsets.symmetric(horizontal: .5.w),
            width: 12.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: const Color(0xfff1f1f1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xff41CDFD)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 2.h),
                Text(
                  "ACTIVE",
                  style: TextStyleClass.smallStyle(
                    color: const Color(0xff72ca8a),
                  ).copyWith(fontSize: 10.sp),
                ),
                CircleAvatar(radius: 2.h, backgroundColor: const Color(0xff72ca8a)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
