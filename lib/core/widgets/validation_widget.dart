import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../config/app_styles.dart';

class ValidationWidget extends StatelessWidget {
  const ValidationWidget({super.key, required this.conditions, this.child});

  final List<Map<String, dynamic>> conditions;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (val) {
        for (var i in conditions) {
          if (i['value']) return i['text'];
        }
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (child != null) child!,
            if (state.hasError) SizedBox(height: 0.5.h),
            if (state.hasError)
              Text(
                state.errorText!,
                style: TextStyleClass.normalStyle().copyWith(color: Colors.red),
              ),
          ],
        );
      },
    );
  }
}
