import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../config/app_styles.dart';
import '../constants/constants.dart';
import '../models/drop_down_class.dart';

class DropDownOptionWidget extends StatefulWidget {
  final DropDownClass dropDownClass;
  final dynamic data;
  final dynamic selected;
  final void Function() rebuild;
  const DropDownOptionWidget({
    required this.dropDownClass,
    super.key,
    required this.data,
    required this.rebuild,
    this.selected,
  });
  @override
  State<DropDownOptionWidget> createState() =>
      _DropDownOptionWidgetState(dropDownClass, data);
}

class _DropDownOptionWidgetState extends State<DropDownOptionWidget> {
  _DropDownOptionWidgetState(this.dropDownClass, this.data);
  DropDownClass dropDownClass;
  dynamic data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.1.h),
      child: InkWell(
        onTap: () async {
          // await dropDownClass.onTap(data);
          widget.rebuild();
          setState(() {});
        },
        child: Container(
          width: 90.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Constants.isTablet ? 2.h : 0.1.h,
            ),
            child: ListTile(
              leading: Transform.scale(
                scale: Constants.isTablet ? 2 : 1,
                child: Radio(
                  value: data,
                  groupValue: widget.selected,
                  onChanged: (val) {
                    dropDownClass.onTap(data);
                    widget.rebuild();
                    setState(() {});
                  },
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              horizontalTitleGap: 2.w,
              visualDensity: VisualDensity.compact,
              title: Row(
                children: [
                  dropDownClass.displayedOptionWidget(data) ?? const SizedBox(),
                  if (dropDownClass.displayedOptionWidget(data) != null)
                    SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      dropDownClass.displayedOptionName(data),
                      style: TextStyleClass.normalStyle(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
