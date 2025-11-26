import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../config/app_styles.dart';

class EmptyAnimation extends StatelessWidget {
  const EmptyAnimation({
    super.key,
    this.width,
    this.height,
    required this.title,
    required this.gif,
    this.aboveText,
  });
  final double? width;
  final double? height;
  final String title;
  final String gif;
  final bool? aboveText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (aboveText != null && aboveText!)
          Text(
            LanguageProvider.translate("global", title),
            style: TextStyleClass.normalStyle().copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        SizedBox(height: 1.h),
        Lottie.asset(gif, fit: BoxFit.cover, width: width, height: height),
        SizedBox(height: 1.h),
        if (aboveText == null)
          Text(
            LanguageProvider.translate("global", title),
            style: TextStyleClass.normalStyle(),
          ),
      ],
    );
  }
}
