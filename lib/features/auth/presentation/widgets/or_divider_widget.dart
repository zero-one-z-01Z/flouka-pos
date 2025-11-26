
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_styles.dart';
import '../../../language/presentation/provider/language_provider.dart';

class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(endIndent: 4, thickness: 1.5, color: Colors.grey.shade300),
        ),
        SizedBox(width: 2.w),
        Text(
          LanguageProvider.translate("auth", "or"),
          style: TextStyleClass.normalStyle().copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Divider(indent: 4, thickness: 1.5, color: Colors.grey.shade300),
        ),
      ],
    );
  }
}
