import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingsContainerWidget extends StatelessWidget {
  const SettingsContainerWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: LinearGradient(
          colors: [Colors.white.withAlpha(70), Colors.white.withAlpha(200)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: child,
    );
  }
}
