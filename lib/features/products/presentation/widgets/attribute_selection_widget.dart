import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'section_title_widget.dart';

class AttributeSelectionWidget extends StatelessWidget {
  final String title;
  final List<String> options;

  const AttributeSelectionWidget({
    super.key,
    required this.title,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(text: title),
        SizedBox(height: 1.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
          decoration: BoxDecoration(
            color: const Color(0xffFAFAFA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: options
                    .map(
                      (opt) => Padding(
                        padding: EdgeInsets.only(right: 1.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.6.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Colors.grey.shade200),
                          ),
                          child: Text(
                            opt,
                            style: TextStyle(
                                color: Colors.black54, fontSize: 10.sp),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ],
    );
  }
}
