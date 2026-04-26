import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SectionTitleWidget extends StatelessWidget {
  final String text;
  final bool isLarge;

  const SectionTitleWidget({
    super.key,
    required this.text,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isLarge ? 16.sp : 10.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}
