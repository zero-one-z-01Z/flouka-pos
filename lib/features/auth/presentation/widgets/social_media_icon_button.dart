import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_styles.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/svg_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';

class SocialMediaIconButton extends StatelessWidget {
  const SocialMediaIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgWidget(svg: Images.google, width: 4.w),
          Text(
            LanguageProvider.translate("auth", "Continue with Google"),
            style: TextStyleClass.normalStyle().copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 4.w),
        ],
      ),
    );
  }
}
