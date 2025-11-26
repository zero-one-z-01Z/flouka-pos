import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/app_images.dart';

class AuthStackImagesWidget extends StatelessWidget {
  const AuthStackImagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 100.w,
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset(Images.circles, fit: BoxFit.fill)),
          Positioned(
            left: 0,
            right: 0,
            bottom: -5.h,
            child: Transform.scale(
              scale: 1.3,
              child: Image.asset(Images.onboardingImage1, width: 50.w),
            ),
          ),
          Positioned(left: 0, right: 0, top: 4.h, child: Image.asset(Images.logo)),
        ],
      ),
    );
  }
}
