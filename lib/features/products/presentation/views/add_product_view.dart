import 'package:flouka_pos/core/widgets/list_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/add_product_provider.dart';

import '../widgets/product_images_section.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final addProductProvider = Provider.of<AddProductProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: buildAppBar(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left section - Basic Details
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(1.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic Details Section
                  Container(
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
                          inputs: addProductProvider.addProductTextFields,
                        ),
                        SizedBox(height: 2.h),

                        // Discounted Price and Tax
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: LanguageProvider.translate(
                                  'product',
                                  'discounted_price',
                                ),
                                controller: addProductProvider.discountController,
                                keyboardType: TextInputType.number,
                                prefix:
                                    '${LanguageProvider.translate('global', 'currency_symbol')} ',
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Consumer<AddProductProvider>(
                                builder: (context, provider, _) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LanguageProvider.translate(
                                          'product',
                                          'tax_included',
                                        ),
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
                                            onChanged: (value) {
                                              provider.updateTaxIncluded(value!);
                                            },
                                            activeColor: AppColor.primaryColor,
                                          ),
                                          Text(
                                            LanguageProvider.translate(
                                              'global',
                                              'yes',
                                            ),
                                            style: TextStyle(fontSize: 11.sp),
                                          ),
                                          SizedBox(width: 2.w),
                                          Radio<bool>(
                                            value: false,
                                            groupValue: provider.taxIncluded,
                                            onChanged: (value) {
                                              provider.updateTaxIncluded(value!);
                                            },
                                            activeColor: AppColor.primaryColor,
                                          ),
                                          Text(
                                            LanguageProvider.translate(
                                              'global',
                                              'no',
                                            ),
                                            style: TextStyle(fontSize: 11.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),

                        // Stock Quantity and Status
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: LanguageProvider.translate(
                                  'product',
                                  'stock_quantity',
                                ),
                                controller: addProductProvider.stockController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Consumer<AddProductProvider>(
                                builder: (context, provider, _) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LanguageProvider.translate(
                                          'global',
                                          'status',
                                        ),
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      DropdownButtonFormField<String>(
                                        value: provider.status,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 2.w,
                                            vertical: 1.5.h,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFE0E0E0),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFE0E0E0),
                                            ),
                                          ),
                                        ),
                                        items: ['Active', 'Inactive']
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(
                                                  LanguageProvider.translate(
                                                    'global',
                                                    e.toLowerCase(),
                                                  ),
                                                  style: TextStyle(fontSize: 11.sp),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          provider.updateStatus(value!);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),

                        // Action Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => addProductProvider.addAttributes(),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 1.5.h,
                                ),
                                side: BorderSide(color: AppColor.primaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                LanguageProvider.translate(
                                  'product',
                                  'add_attributes',
                                ),
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            ElevatedButton(
                              onPressed: () => addProductProvider.publishProduct(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4.w,
                                  vertical: 1.5.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                LanguageProvider.translate(
                                  'product',
                                  'publish_product',
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right section - Product Images
          const Expanded(flex: 3, child: ProductImagesSection()),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        LanguageProvider.translate('global', 'products'),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {},
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            children: [
              Text(
                'En',
                style: TextStyle(color: Colors.black, fontSize: 12.sp),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.black, size: 18.sp),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? prefix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixText: prefix,
            contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
