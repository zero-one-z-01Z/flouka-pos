import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_styles.dart';
import '../../../../core/widgets/button_widget.dart';

class EditButtonWidget extends StatelessWidget {
  EditButtonWidget({super.key, required this.onTap, this.width});

  double? width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      color: const Color(0xffdbf6ff),
      height: 2.h,
      width: width ?? 4.w,
      borderRadius: 4,
      onTap: onTap,
      text: "EDIT",
      textStyle: TextStyleClass.smallStyle().copyWith(
        fontSize: 12.sp,
        color: const Color(0xff00A8E1),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
