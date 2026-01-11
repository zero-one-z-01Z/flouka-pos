import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../language/presentation/provider/language_provider.dart';

class PerformanceTableHeaderWidget extends StatelessWidget {
  const PerformanceTableHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: const Color(0xffF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _tableCell(LanguageProvider.translate('global', 'image_label'), flex: 1),
          _tableCell(LanguageProvider.translate('global', 'product_name'), flex: 3),
          _tableCell(LanguageProvider.translate('global', 'sold_qty'), flex: 1),
          _tableCell(LanguageProvider.translate('global', 'revenue'), flex: 1.2),
          _tableCell(
            LanguageProvider.translate('global', 'profit_percent'),
            flex: 1.2,
          ),
          _tableCell(LanguageProvider.translate('global', 'status'), flex: 1.5),
        ],
      ),
    );
  }

  Widget _tableCell(String text, {required double flex}) {
    return Expanded(
      flex: (flex * 10).toInt(),
      child: Text(
        text,
        textAlign: flex == 1 ? TextAlign.center : TextAlign.start,
        style: TextStyleClass.smallStyle().copyWith(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: const Color(0xff6B7280),
        ),
      ),
    );
  }
}
