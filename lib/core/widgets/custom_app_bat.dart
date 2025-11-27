import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../features/home/presentation/providers/home_provider.dart';
import '../constants/app_images.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    return Container(
      padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 2.w, right: 2.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xfff6f6f6))),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: () {
              homeProvider.toggleDrawer();
            },
            child: const Icon(Icons.menu),
          ),
          SizedBox(width: 3.w),

          // Search Bar
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xFF9E9E9E)),
                  SizedBox(width: 1.w),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 9.sp,
                          color: const Color(0xFF9E9E9E),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 2.w),

          // Language Selector
          Container(
            padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  'En',
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 0.5.w),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF9E9E9E),
                  size: 20,
                ),
              ],
            ),
          ),
          SizedBox(width: 1.w),

          // Notification Icon
          Container(
            padding: EdgeInsets.all(1.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(
              Images.appBarNotification,
              width: 2.5.h,
              height: 2.5.h,
            ),
          ),
        ],
      ),
    );
  }
}
