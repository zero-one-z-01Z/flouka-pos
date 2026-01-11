import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_styles.dart';
import '../../../language/presentation/provider/language_provider.dart';
import 'order_details_item_widget.dart';
class ItemSummarySection extends StatelessWidget {
  const ItemSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageProvider.translate("global", "Item Summary"),
            style: TextStyleClass.smallStyle().copyWith(),
          ),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: List.generate(6, (index) => const OrderDetailsItemWidget()),
          ),
        ],
      ),
    );
  }
}
