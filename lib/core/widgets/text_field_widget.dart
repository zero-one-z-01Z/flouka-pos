import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../config/app_color.dart';
import '../config/app_styles.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';

class TextFieldWidget extends StatelessWidget {
  final bool obscureText, autoFocus, otp, readOnly, next, isLabel;
  final TextEditingController controller;
  final double? width, height, verticalPadding, borderRadius, elevation, borderWidth;
  final Widget? titleWidget, prefix, suffix;
  final void Function(String)? onChange;
  final void Function()? onTextTap, onEditingComplete, onSuffixTap;
  final int? maxLines, maxLength, minLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? counter, hintText;
  final Color? color,
      borderColor,
      cursorColor,
      focusedBorder,
      enabledBorder,
      hintColor;
  final TextStyle? style;
  final TextAlign? textAlign;
  final EdgeInsets? contentPadding;

  const TextFieldWidget({
    this.maxLines,
    this.hintText,
    this.cursorColor,
    required this.controller,
    this.height,
    this.width,
    this.style,
    this.focusedBorder,
    this.enabledBorder,
    this.isLabel = false,
    this.color,
    this.borderColor = Colors.grey,
    this.borderRadius = 8,
    this.counter,
    this.autoFocus = false,
    this.keyboardType,
    this.maxLength,
    this.next = true,
    this.obscureText = false,
    this.textAlign,
    this.onChange,
    this.onEditingComplete,
    this.onSuffixTap,
    this.otp = false,
    this.prefix,
    this.readOnly = false,
    this.suffix,
    this.onTextTap,
    this.titleWidget,
    this.validator,
    this.verticalPadding,
    super.key,
    this.minLines,
    this.contentPadding,
    this.elevation,
    this.borderWidth,
    this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (titleWidget != null) ...[titleWidget!, SizedBox(height: 0.8.h)],
          Material(
            borderRadius: BorderRadius.circular(borderRadius ?? 3.w),
            elevation: elevation ?? 0,
            color: Colors.transparent,
            child: SizedBox(
              width: width ?? 100.w,
              height: height,
              child: TextFormField(
                textAlign: textAlign ?? TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                obscureText: obscureText,
                onChanged: onChange,
                controller: controller,
                onTap:
                    onTextTap ??
                    () {
                      final c = controller;
                      if (c.selection ==
                          TextSelection.fromPosition(
                            TextPosition(offset: c.text.length - 1),
                          )) {
                        c.selection = TextSelection.fromPosition(
                          TextPosition(offset: c.text.length),
                        );
                      }
                    },
                minLines: minLines,
                cursorColor: cursorColor ?? Colors.black,
                readOnly: readOnly,
                autofocus: autoFocus,
                maxLines: maxLines ?? 1,
                maxLength: maxLength,
                style: style ?? TextStyle(fontSize: 15.sp, color: Colors.black),
                validator:
                    validator ??
                    (value) {
                      if (value!.isEmpty) {
                        return LanguageProvider.translate('validation', 'field');
                      }
                      return null;
                    },
                onEditingComplete:
                    onEditingComplete ??
                    () {
                      FocusScope.of(context).unfocus();
                      if (next) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                keyboardType: keyboardType,
                decoration: inputDecoration(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      counterText: counter ?? "",
      isDense: true,
      counterStyle: TextStyleClass.normalStyle().copyWith(fontSize: 10),
      hintText: hintText == null
          ? null
          : LanguageProvider.translate('inputs', hintText!),
      fillColor: color ?? Colors.white,
      filled: true,
      hintStyle: TextStyleClass.normalStyle()
          .copyWith(fontSize: 10)
          .copyWith(color: hintColor ?? Colors.grey[600], fontSize: 15.sp)
          .copyWith(height: 1.2.sp),
      labelStyle: TextStyleClass.normalStyle().copyWith(
        color: const Color(0xff8F8C8C),
      ),
      floatingLabelStyle: TextStyleClass.normalStyle(),
      floatingLabelBehavior: isLabel
          ? FloatingLabelBehavior.always
          : FloatingLabelBehavior.never,
      border: focusedBorder != null
          ? null
          : border(
              borderRadius: borderRadius,
              color: borderColor,
              otp: otp,
              borderWidth: borderWidth,
            ),
      disabledBorder: border(
        borderRadius: borderRadius,
        color: borderColor,
        otp: otp,
      ),
      focusedBorder: border(
        borderRadius: borderRadius,
        color: focusedBorder ?? borderColor,
        borderWidth: focusedBorder == null ? 0 : 3,
        otp: otp,
      ),
      enabledBorder: border(
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        color: enabledBorder ?? borderColor,
        otp: otp,
      ),
      errorBorder: border(
        borderWidth: borderWidth,
        color: Colors.red,
        borderRadius: borderRadius,
        otp: otp,
      ),
      focusedErrorBorder: border(
        borderWidth: borderWidth,
        color: Colors.red,
        borderRadius: borderRadius,
        otp: otp,
      ),
      hoverColor: Colors.grey,
      prefixIcon: prefix,
      errorStyle: TextStyleClass.normalStyle().copyWith(color: Colors.red),
      contentPadding:
          contentPadding ??
          EdgeInsets.only(
            left: 3.w,
            right: 5.w,
            top: Constants.isTablet ? 1.4.h : 1.9.h,
            bottom: 2.2.h,
          ),
      suffixIcon:
          suffix ??
          (onSuffixTap == null
              ? null
              : IconButton(
                  onPressed: onSuffixTap,
                  icon: Icon(
                    obscureText ? Icons.visibility_off_outlined : Icons.visibility,
                    size: 20,
                    color: obscureText ? Colors.grey : AppColor.primaryColor,
                  ),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                )),
    );
  }

  static InputBorder border({
    Color? color,
    double? borderRadius,
    double? borderWidth,
    bool otp = false,
  }) {
    if (otp) {
      return UnderlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        borderSide: BorderSide(
          color: color ?? const Color(0xff8F8C8C),
          width: borderWidth ?? 5.sp,
        ),
      );
    }
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      borderSide: BorderSide(
        color: color ?? const Color(0xff8F8C8C),
        width: borderWidth ?? 1.sp,
      ),
    );
  }
}
