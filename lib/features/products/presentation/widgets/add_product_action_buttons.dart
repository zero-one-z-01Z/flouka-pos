import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/add_product_provider.dart';
import '../providers/add_variant_provider.dart';

class AddProductActionButtons extends StatelessWidget {
  const AddProductActionButtons({super.key,});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddProductProvider>(context, listen: false);
    final variantProvider = Provider.of<AddVariantProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if(provider.product != null)
        OutlinedButton(
          onPressed: () {variantProvider.goToAddVariantView(id: "${provider.product?.category?.id}");},
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
                'buttons', provider.product != null ? 'update_product' : 'add_product'),
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
