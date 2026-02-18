import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_color.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/add_product_provider.dart';

class AddProductTaxSection extends StatelessWidget {
  const AddProductTaxSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddProductProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LanguageProvider.translate('product', 'tax_included'),
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: provider.taxIncluded,
                  onChanged: (value) =>
                      provider.updateTaxIncluded(value!),
                  activeColor: AppColor.primaryColor,
                ),
                Text(
                  LanguageProvider.translate('global', 'yes'),
                  style: TextStyle(fontSize: 11.sp),
                ),
                SizedBox(width: 2.w),
                Radio<bool>(
                  value: false,
                  groupValue: provider.taxIncluded,
                  onChanged: (value) =>
                      provider.updateTaxIncluded(value!),
                  activeColor: AppColor.primaryColor,
                ),
                Text(
                  LanguageProvider.translate('global', 'no'),
                  style: TextStyle(fontSize: 11.sp),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
