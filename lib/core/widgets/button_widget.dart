import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../config/app_color.dart';
import '../config/app_styles.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';

class ButtonWidget extends StatelessWidget {
  final double? width, height, borderRadius, elevation;
  final void Function() onTap;
  final Color? color, borderColor;
  final String text;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? directionBorderRadius;
  final TextStyle? textStyle;
  final Widget? widget;
  final bool widgetAfterText, takeSmallestWidth, withShadow;
  final bool? isSpaceBetween;
  final double? spacing;
  const ButtonWidget({
    this.spacing,
    this.widget,
    this.width,
    this.withShadow = false,
    this.height,
    this.directionBorderRadius,
    required this.onTap,
    this.borderRadius,
    required this.text,
    this.textStyle,
    this.borderColor,
    this.color,
    this.widgetAfterText = true,
    super.key,
    this.takeSmallestWidth = false,
    this.elevation,
    this.padding,
    this.isSpaceBetween,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: takeSmallestWidth ? null : (width ?? 90.w),
        height: height ?? (Constants.isTablet ? 7.h : 6.h),
        decoration: BoxDecoration(
          borderRadius:
              directionBorderRadius ?? BorderRadius.circular(borderRadius ?? 10),
          color: color ?? AppColor.primaryColor,

          border: borderColor == null || color == null
              ? null
              : Border.all(color: borderColor!),
          boxShadow: [
            if (withShadow)
              BoxShadow(
                color: const Color(0xffFC6011).withAlpha((0.32 * 255).round()),
                blurRadius: 6,
                offset: const Offset(0, 3),
                spreadRadius: 0,
              ),
          ],
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            spacing: spacing ?? 0,
            mainAxisAlignment: isSpaceBetween == true
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              if (!widgetAfterText) widget ?? const SizedBox(),
              Text(
                LanguageProvider.translate("buttons", text),
                style:
                    textStyle ??
                    TextStyleClass.normalStyle(
                      color: Colors.white,
                    ).copyWith(fontSize: 17.sp),
              ),
              if (isSpaceBetween == true) const SizedBox(),
              if (widgetAfterText) widget ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class BorderButtonWidget extends StatelessWidget {
  final double? width, height, borderRadius;
  final void Function() onTap;
  final Color? color;
  final String text;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Widget? widget;
  final bool widgetAfterText, takeSmallestWidth;
  const BorderButtonWidget({
    this.widget,
    this.width,
    this.height,
    required this.onTap,
    this.borderRadius,
    required this.text,
    this.textStyle,
    this.color,
    this.widgetAfterText = true,
    super.key,
    this.takeSmallestWidth = false,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: takeSmallestWidth ? null : (width ?? 90.w),
        height: height ?? (Constants.isTablet ? 7.h : 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          color: Colors.white,
          border: Border.all(color: color ?? AppColor.primaryColor),
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!widgetAfterText) widget ?? const SizedBox(),
              if (!widgetAfterText && widget != null) SizedBox(width: 3.w),
              Text(
                LanguageProvider.translate("buttons", text),
                style:
                    textStyle ??
                    TextStyleClass.normalStyle(color: color ?? Colors.white),
              ),
              if (widgetAfterText && widget != null) SizedBox(width: 3.w),
              if (widgetAfterText) widget ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
