import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/widgets/drop_down_widget.dart';
import 'package:flouka_pos/core/widgets/upload_image_widget.dart';
import 'package:flouka_pos/core/widgets/upload_multi_image_widget.dart';
import 'package:flouka_pos/core/widgets/validation_widget.dart';
import 'package:flouka_pos/features/categories/presentation/providers/categories_provider.dart';
import 'package:flouka_pos/features/categories/presentation/providers/subcategory_provider.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/products/presentation/providers/add_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../categories/presentation/providers/brands_provider.dart';

class ProductImagesSection extends StatelessWidget {
  const ProductImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of(context);
    SubcategoryProvider subcategoryProvider = Provider.of(context);
    BrandsProvider brandsProvider = Provider.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upload Product Image Section
          Container(
            padding: EdgeInsets.only(top: 3.w, bottom: 2.w, left: 3.w, right: 3.w),
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
            child: Consumer<AddProductProvider>(
              builder: (context, provider, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LanguageProvider.translate('product', 'upload_product_images'),
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 2.h),
                    // Multiple Images Upload Widget
                    UploadMultiImageWidget(
                      images: provider.productImages,
                      count: 5,
                      deleteImage: (index) {
                        provider.deleteImage(index);
                      },
                      imagesList: (images) {
                        provider.addToImages(images);
                      },
                      title: 'upload_product_images',
                      translationSection: 'product',
                    ),
                    SizedBox(height: 1.h,),
                    ValidationWidget(conditions: [
                      {"value": provider.productImages.isEmpty,
                        "text": LanguageProvider.translate("product", "select_product_images")}
                    ]),
                    SizedBox(height: 2.h),

                    // Categories Section
                    Text(
                      LanguageProvider.translate('global', 'categories'),
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 2.h),
                    DropDownWidget(dropDownClass:categoryProvider ),
                    SizedBox(height: 2.h),
                    DropDownWidget(dropDownClass:subcategoryProvider ),
                    SizedBox(height: 1.h,),
                    ValidationWidget(conditions: [
                      {"value": subcategoryProvider.selectedSubcategory == null||categoryProvider.selectedCategory == null,
                        "text": LanguageProvider.translate("product", "select_category_subcategory")}
                    ]),
                    SizedBox(height: 1.h,),
                    Text(
                      LanguageProvider.translate('global', 'select_brand'),
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 2.h),
                    DropDownWidget(dropDownClass:brandsProvider ),
                    SizedBox(height: 1.h,),
                    ValidationWidget(conditions: [
                      {"value": brandsProvider.selectedBrand == null,
                        "text": LanguageProvider.translate("product", "select_brand")}
                    ]),

                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
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
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
            suffixIcon: const Icon(Icons.arrow_drop_down),
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
          readOnly: true, // Making it look like a dropdown as per UI
        ),
      ],
    );
  }
}
