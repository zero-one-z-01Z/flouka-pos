import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/widgets/upload_image_widget.dart';
import 'package:flouka_pos/core/widgets/upload_multi_image_widget.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/products/presentation/providers/add_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProductImagesSection extends StatelessWidget {
  const ProductImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                      LanguageProvider.translate('product', 'upload_product_image'),
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 2.h),

                    // Main Product Image Label
                    Text(
                      LanguageProvider.translate('product', 'product_image'),
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 1.h),

                    // Single Image Upload Widget
                    UploadImageWidget(
                      image: provider.mainProductImage,
                      onImageSelected: (image) {
                        provider.updateMainImage(image);
                      },
                      onImageRemoved: () {
                        provider.updateMainImage(null);
                      },
                    ),
                    SizedBox(height: 2.h),

                    // Multiple Images Upload Widget
                    UploadMultiImageWidget(
                      images: provider.productImages,
                      count: 5,
                      deleteImage: (index) {
                        provider.deleteProductImage(index);
                      },
                      imagesList: (images) {
                        provider.addProductImages(images);
                      },
                      title: 'upload_product_images',
                      translationSection: 'product',
                    ),
                    SizedBox(height: 2.h),

                    // Categories Section
                    Text(
                      LanguageProvider.translate('global', 'categories'),
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 2.h),

                    // Product Categories
                    _buildTextField(
                      label: LanguageProvider.translate(
                        'product',
                        'product_categories',
                      ),
                      controller: TextEditingController(
                        text: LanguageProvider.translate('global', 'mobiles'),
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Brand
                    _buildTextField(
                      label: LanguageProvider.translate('filter', 'brand'),
                      controller: TextEditingController(text: 'iPhone'),
                    ),
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
