import 'package:flouka_pos/features/products/presentation/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../category/presentation/providers/category_provider.dart';
import '../../../../category/presentation/widgets/category_filter_item_widget.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.h),
          Text(
            "Categories",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2.h),
          const CategriesListFilterWidget(),
          SizedBox(height: 2.h),
          Text(
            "Products",
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 1.w,
            runSpacing: 1.h,
            children: List.generate(6, (index) => const ProductItemWidget()),
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
      spacing: 1.w,
      children: List.generate(
        categoryProvider.categories.length,
        (index) =>
            CategoryFilterItem(categoryName: categoryProvider.categories[index]),
      ),
    );
  }
}
