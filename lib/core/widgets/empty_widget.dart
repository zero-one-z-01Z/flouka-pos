import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../config/app_styles.dart';
import '../../features/language/presentation/provider/language_provider.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final String image;
  final double? width;
  const EmptyWidget({
    super.key,
    required this.title,
    required this.image,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset(image, fit: BoxFit.cover, width: width),
        ),
        Text(
          LanguageProvider.translate("empty", title),
          style: TextStyleClass.normalStyle(),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
