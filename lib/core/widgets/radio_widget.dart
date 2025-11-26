import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../config/app_color.dart';
import '../constants/constants.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({
    super.key,
    required this.selected,
    this.onTap,
    this.color,
  });
  final bool selected;
  final void Function()? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Constants.isTablet ? 5.w : 5.w,
        height: Constants.isTablet ? 5.w : 5.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: color ?? AppColor.primaryColor,
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.all(0.7.w),
        child: Container(
          decoration: BoxDecoration(
            color: selected
                ? (color ?? AppColor.primaryColor)
                : null,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
