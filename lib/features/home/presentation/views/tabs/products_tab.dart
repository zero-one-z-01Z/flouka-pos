import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/features/home/presentation/providers/home_provider.dart';
import 'package:flouka_pos/features/products/presentation/widgets/product_item_widget.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../category/presentation/providers/category_provider.dart';
import '../../../../category/presentation/widgets/category_filter_item_widget.dart';
import '../../../../products/presentation/providers/product_provider.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context); 
    final dummyProducts = productProvider.dummyProducts;
    final navProvider = Provider.of<HomeProvider>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.h),

          // Categories
          Text(
            LanguageProvider.translate('global', 'categories'),
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2.h),
          const CategriesListFilterWidget(),
          SizedBox(height: 2.h),

          // Products
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LanguageProvider.translate('global', 'products'),
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              ButtonWidget(onTap: (){
                navProvider.setSelectedNavigation(
                  navProvider.navigationList.firstWhere(
                    (nav) => nav.title == 'AddProduct',
                  ),
                );
              }, text: LanguageProvider.translate('buttons', 'add_products'), width: 15.w, height: 5.h, borderRadius: 9.sp, )
            ],
          ),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 2.w,
            runSpacing: 2.h,
            children: dummyProducts.map((product) {
              return ProductItemWidget(
                product: product,
                onActiveChanged: (val) => product.isActive = val,
                onEdit: () => print("Edit ${product.name}"),
                onDelete: () => print("Delete ${product.name}"),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class CategriesListFilterWidget extends StatelessWidget {
  const CategriesListFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryProvider categoryProvider = Provider.of(context);
    return Row(
      children: List.generate(
        categoryProvider.categories.length,
        (index) => CategoryFilterItem(
          categoryName: categoryProvider.categories[index],
        ),
      ),
    );
  }
}
