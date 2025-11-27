import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({super.key});

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
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 0.5.h),

          // Username
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Username: ',
                style: TextStyle(fontSize: 8.sp, color: Colors.black54),
              ),
              Text(
                'moaz.layd',
                style: TextStyle(fontSize: 8.sp, color: Colors.black87),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Store Status
          Text(
            'Store Status',
            style: TextStyle(fontSize: 8.sp, color: Colors.black54),
          ),
          SizedBox(height: 1.h),

          // Active Status Button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF4CAF50)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ACTIVE',
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4CAF50),
                  ),
                ),
                SizedBox(width: 1.w),
                Container(
                  width: 2.h,
                  height: 2.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
