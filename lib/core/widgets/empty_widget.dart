import 'package:flutter/material.dart';
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
        // Stack(children: [
        //   SvgWidget(svg: Images.emptyIcon, width: 40.w),
        //   Positioned(
        //       bottom: 0,
        //       right: 0,
        //       left: 0,
        //       child: SvgWidget(
        //           svg: Images.emptyCartIcon,
        //           color: AppColor.defaultBlackColor,
        //           width: 40.w))
        // ]),
        Center(
          child: Image.asset(
            image,
            width: width ?? 70.w,
            fit: BoxFit.contain,
          ),
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
