import 'package:flouka_pos/features/category/presentation/widgets/category_filter_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';

class CategoriesListWidget extends StatelessWidget {
  const CategoriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
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
