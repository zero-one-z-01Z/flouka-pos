import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../config/app_styles.dart';
import '../../features/language/presentation/provider/language_provider.dart';

class LoadingAnimationWidget extends StatelessWidget {
  const LoadingAnimationWidget({
    super.key,
    required this.gif,
    this.width,
    this.height,
    this.topPadding,
  });
  final double? width;
  final double? height;
  final double? topPadding;
  final String gif;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: topPadding ?? 12.h),
        Lottie.asset(
          gif,
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
        SizedBox(height: 5.h),
        Text(
          LanguageProvider.translate("global", "loading"),
          style: TextStyleClass.normalStyle(),
        ),
      ],
    );
  }
}
