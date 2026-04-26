import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../category/presentation/widgets/categories_list_widget.dart';
import '../../../../products/presentation/widgets/product_item_widget.dart';
import '../../../../products/presentation/providers/product_provider.dart';
import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/features/home/presentation/providers/home_provider.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';

import '../../../../products/presentation/widgets/product_preview_overlay.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final navProvider = Provider.of<HomeProvider>(context);

    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),

              // Categories
              const CategoriesListWidget(),
              SizedBox(height: 2.h),

              // Products header + add button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LanguageProvider.translate('global', 'products'),
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                  ButtonWidget(
                    onTap: () {
                      navProvider.setSelectedNavigation(
                        navProvider.navigationList.firstWhere(
                          (nav) => nav.title == 'AddProduct',
                        ),
                      );
                    },
                    text: LanguageProvider.translate('buttons', 'add_products'),
                    width: 15.w,
                    height: 5.h,
                    borderRadius: 9.sp,
                  )
                ],
              ),
              SizedBox(height: 2.h),

              // Products Grid
              Wrap(
                spacing: 2.w,
                runSpacing: 2.h,
                children: List.generate(
                  productProvider.products.length,
                  (index) {
                    final product = productProvider.products[index];
                    return ProductItemWidget(
                      product: product,
                      index: index,
                      onEdit: () => print("Edit ${product.name}"),
                      onDelete: () => print("Delete ${product.name}"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        /// Product Preview Overlay
        if (productProvider.isPreviewOpen &&
            productProvider.selectedProduct != null)
          ProductPreviewOverlay(product: productProvider.selectedProduct!)
      ],
    );
  }
}
