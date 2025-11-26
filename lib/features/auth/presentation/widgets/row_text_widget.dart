import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';

class RowTextWidget extends StatelessWidget {
  const RowTextWidget({
    super.key,
    required this.normalText,
    required this.highlightedTextWithonTap,
  });
  final String normalText;
  final String highlightedTextWithonTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Text(
          normalText,
          style: TextStyleClass.headStyle().copyWith(
            // color: AppColor.primaryColor,
            fontSize: 15.sp,
          ),
        ),
        Text(
          highlightedTextWithonTap,
          style: TextStyleClass.headStyle().copyWith(
            color: Colors.black,
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }
}
