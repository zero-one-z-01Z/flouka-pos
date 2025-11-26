import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../config/app_color.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({
    super.key,
    required this.check,
    required this.onChange,
    this.padding,
  });
  final bool check;
  final EdgeInsets? padding;
  final void Function(bool val) onChange;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange(!check);
      },
      child: Container(
        width: 20.sp,
        height: 20.sp,
        // margin: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          color: check ? AppColor.primaryColor : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.primaryColor, width: 6),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: check ? AppColor.primaryColor : Colors.white,
          ),
          child: const Icon(Icons.check, color: Colors.white),
        ),
      ),
    );
  }
}
