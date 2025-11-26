import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../config/app_styles.dart';
import '../constants/constants.dart';
import '../dialog/drop_down_dialog.dart';
import '../models/drop_down_class.dart';

class DropDownWidget extends StatefulWidget {
  final DropDownClass dropDownClass;
  final double? width, borderRadius;
  final Color? borderColor, color;
  final double? padding;
  final void Function()? onTap, onChanged, clear;
  final TextEditingController? controller;
  final double borderWidth;
  const DropDownWidget({
    required this.dropDownClass,
    this.width,
    super.key,
    this.onTap,
    this.controller,
    this.borderRadius,
    this.borderColor,
    this.padding,
    this.color,
    this.onChanged,
    this.clear,
    this.borderWidth = .5,
  });
  @override
  State<DropDownWidget> createState() => DropDownWidgetState(dropDownClass);
}

class DropDownWidgetState extends State<DropDownWidget> {
  DropDownClass dropDownClass;
  DropDownWidgetState(this.dropDownClass);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            if (widget.onTap == null) {
              if (widget.clear != null) {
                widget.clear!();
              }
              showDropDownDialog(dropDownClass).then((value) => setState(() {}));
            } else {
              widget.onTap!();
            }
          },
          child: Container(
            width: widget.width ?? 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
              color: widget.color ?? const Color(0xffF0F0F0),
              border: Border.all(
                color: widget.borderColor ?? Colors.grey,
                width: widget.borderWidth,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
                vertical: widget.padding ?? 0.7.h,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  dropDownClass.displayedWidget() ?? const SizedBox(),
                  if (dropDownClass.displayedWidget() != null) SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      dropDownClass.displayedName(),
                      maxLines: 1,
                      style: TextStyleClass.normalStyle(color: Colors.black),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.grey,
                    size: Constants.isTablet ? 60 : 30,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
