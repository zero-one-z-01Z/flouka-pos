import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../language/presentation/provider/language_provider.dart';

class PerformanceHeaderWidget extends StatelessWidget {
  const PerformanceHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
      child: Text(
        LanguageProvider.translate('global', 'product_performance'),
        style: TextStyleClass.smallStyle().copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xff111827),
        ),
      ),
    );
  }
}
