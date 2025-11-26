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
    this.borderRadius = 20,
    this.borderWidth = .7,
  });
  final List<TextFieldModel> inputs;
  final TextStyle? style;
  final bool? isGradient;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor, errorStyleColor, textColor, color;

  @override
  Widget build(BuildContext context) {
    List<String> telInputs = ['phone', 'whats'];
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: List.generate(inputs.length, (index) {
          TextFieldWidget textFieldWidget = TextFieldWidget(
            borderRadius: borderRadius ?? 3.w,
            borderWidth: borderWidth,
            titleWidget: Builder(
              builder: (ctx) {
                if (inputs[index].titleWidgets != null) {
                  return Row(children: [...inputs[index].titleWidgets!]);
                }
                if (inputs[index].title != null) {
                  return inputs[index].title!;
                }
                if (inputs[index].editTextString != null) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        inputs[index].editTextString!,
                        style: TextStyleClass.normalStyle(color: Colors.black),
                      ),
                      SizedBox(width: 1.w),
                    ],
                  );
                }
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (inputs[index].image != null)
                      SvgWidget(
                        svg: inputs[index].image!,
                        width: Constants.isTablet ? 5.w : null,
                        color: textColor,
                      ),
                    if (inputs[index].image != null) SizedBox(width: 2.w),
                    if (inputs[index].label != null)
                      Text(
                        LanguageProvider.translate('inputs', inputs[index].label!),
                        style:
                            style ??
                            TextStyleClass.normalStyle(
                              color: textColor ?? Colors.black,
                            ).copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
                      ),
                  ],
                );
              },
            ),

            color: color,
            borderColor: borderColor,
            isLabel: inputs[index].isLabel ?? false,
            maxLength: telInputs.contains(inputs[index].key) ? 10 : null,
            controller: inputs[index].controller,
            keyboardType: inputs[index].textInputType,
            next: inputs.length - 1 != index,
            hintText: inputs[index].hint,
            onTextTap: inputs[index].onTap,
            minLines: inputs[index].min,
            maxLines: inputs[index].max,
            validator: inputs[index].validator,
            obscureText: inputs[index].obscureText,
            suffix: inputs[index].suffix,
            prefix: inputs[index].prefix,
            readOnly: inputs[index].readOnly,
            width: inputs[index].width,
            contentPadding: inputs[index].contentPadding,
          );
          return textFieldWidget;
        }),
      ),
    );
  }
}
