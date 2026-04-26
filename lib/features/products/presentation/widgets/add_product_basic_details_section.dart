import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/widgets/list_text_field_widget.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/add_product_provider.dart';
import 'add_product_tax_section.dart';
import 'add_product_stock_section.dart';
import 'add_product_action_buttons.dart';
import 'add_product_text_field.dart';

class AddProductBasicDetailsSection extends StatelessWidget {
  final AddProductProvider provider;

  const AddProductBasicDetailsSection({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
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

          Row(
            children: [
              Expanded(
                child: AddProductTextField(
                  label: LanguageProvider.translate(
                      'product', 'discounted_price'),
                  controller: provider.discountController,
                  keyboardType: TextInputType.number,
                  prefix:
                      '${LanguageProvider.translate('global', 'currency_symbol')} ',
                ),
              ),
              SizedBox(width: 3.w),
              const Expanded(child: AddProductTaxSection()),
            ],
          ),

          SizedBox(height: 2.h),

          const AddProductStockSection(),

          SizedBox(height: 3.h),

          AddProductActionButtons(provider: provider),
        ],
      ),
    );
  }
}
