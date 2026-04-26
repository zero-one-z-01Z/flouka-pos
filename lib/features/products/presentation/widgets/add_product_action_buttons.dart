import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/add_product_provider.dart';

class AddProductActionButtons extends StatelessWidget {
  final AddProductProvider provider;

  const AddProductActionButtons({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () => provider.addAttributes(),
          style: OutlinedButton.styleFrom(
            padding:
                EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
            side: BorderSide(color: AppColor.primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            LanguageProvider.translate(
                'product', 'add_attributes'),
            style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 11.sp,
            ),
          ),
        ),
        SizedBox(width: 2.w),
        ElevatedButton(
          onPressed: () => provider.publishProduct(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
            padding:
                EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            LanguageProvider.translate(
                'product', 'publish_product'),
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
            ),
          ),
        ),
      ],
    );
  }
}
