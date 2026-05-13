import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../config/app_styles.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../constants/constants.dart';
import '../models/text_field_model.dart';
import 'svg_widget.dart';
import 'text_field_widget.dart';

class ListTextFieldWidget extends StatelessWidget {
  const ListTextFieldWidget({
    super.key,
    required this.inputs,
    this.style,
    this.color,
    this.borderColor,
    this.isGradient,
    this.textColor,
    this.errorStyleColor,
    this.borderRadius = 15,
    this.borderWidth = .7,
  });

  final List<TextFieldModel> inputs;
  final TextStyle? style;
  final bool? isGradient;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? errorStyleColor;
  final Color? textColor;
  final Color? color;

  @override
Widget build(BuildContext context) {
  final parentWidth = MediaQuery.of(context).size.width;

  // Since RegisterView has horizontal padding of 6.w
  final horizontalPadding = 12.w; // 6.w left + 6.w right
  final spacing = 4.w;

  final availableWidth = parentWidth - horizontalPadding;
  final fieldWidth = (availableWidth - spacing) / 2;

  return SizedBox(
    width: double.infinity,
    child: Wrap(
      spacing: spacing,
      runSpacing: 2.h,
      // alignment: WrapAlignment.center,
      children: inputs.map((input) {
        return TextFieldWidget(
          borderRadius: borderRadius ?? 3.w,
          borderWidth: borderWidth,
          titleWidget: _buildTitle(context, input),
          color: color,
          borderColor: borderColor,
          isLabel: input.isLabel ?? false,
          controller: input.controller,
          keyboardType: input.textInputType,
          width: input.width,
          next: inputs.last != input,
          hintText: input.hint,
          validator: input.validator,
          obscureText: input.obscureText,
          suffix: input.suffix,
          prefix: input.prefix,
          readOnly: input.readOnly,
          contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        );
      }).toList(),
    ),
  );
}


  /// Builds dynamic title widget safely and cleanly
  Widget _buildTitle(BuildContext context, TextFieldModel input) {
    if (input.titleWidgets != null) {
      return Row(children: input.titleWidgets!);
    }

    if (input.title != null) {
      return input.title!;
    }

    if (input.editTextString != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            input.editTextString!,
            style: TextStyleClass.normalStyle(color: Colors.black),
          ),
          SizedBox(width: 1.w),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (input.image != null)
          SvgWidget(
            svg: input.image!,
            width: Constants.isTablet ? 5.w : null,
            color: textColor,
          ),
        if (input.image != null) SizedBox(width: 2.w),
        if (input.label != null)
          Text(
            LanguageProvider.translate('inputs', input.label!),
            style: style ??
                TextStyleClass.normalStyle(
                  color: textColor ?? Colors.black,
                ).copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
          ),
      ],
    );
  }
}
