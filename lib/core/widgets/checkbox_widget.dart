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
        width: 15.sp,
        height: 15.sp,
        decoration: BoxDecoration(
          color: check ? AppColor.primaryColor : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: AppColor.primaryColor, width: 2),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: check ? AppColor.primaryColor : Colors.white,
          ),
          child: check ?Icon(Icons.check, color: Colors.white,size: 1.5.w,):null,
        ),
      ),
    );
  }
}
