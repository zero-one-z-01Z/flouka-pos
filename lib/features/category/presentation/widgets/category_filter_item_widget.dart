import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CategoryFilterItem extends StatelessWidget {
  const CategoryFilterItem({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: const Color(0xffeaeaea),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(categoryName, style: TextStyle(fontSize: 11.sp)),
    );
  }
}
