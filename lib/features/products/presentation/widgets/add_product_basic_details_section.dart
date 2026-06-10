import 'package:flouka_pos/core/config/app_styles.dart';
import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/widgets/list_text_field_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/add_product_provider.dart';
import 'add_product_tax_section.dart';
import 'add_product_stock_section.dart';
import 'add_product_action_buttons.dart';
import 'add_product_text_field.dart';
import 'tags_widget.dart';

class AddProductBasicDetailsSection extends StatelessWidget {
  const AddProductBasicDetailsSection({super.key,});

  @override
  Widget build(BuildContext context) {
    final AddProductProvider provider = Provider.of(context);
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageProvider.translate('product', 'basic_details'),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),

          ListTextFieldWidget(
            inputs: provider.addProductTextFields,
          ),

          SizedBox(height: 2.h),
          if(provider.tags.isNotEmpty)
          const TagsWidget(),
          ButtonWidget(color: AppColor.primaryColor.withOpacity(0.7),onTap: (){
            provider.showAddWidget();
          }, text: "add_tags"),
          SizedBox(height: 2.h),
          const AddProductActionButtons(),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
