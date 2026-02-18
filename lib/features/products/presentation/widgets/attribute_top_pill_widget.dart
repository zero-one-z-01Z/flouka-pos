import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AttributeTopPillWidget extends StatelessWidget {
  final String label;

  const AttributeTopPillWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
