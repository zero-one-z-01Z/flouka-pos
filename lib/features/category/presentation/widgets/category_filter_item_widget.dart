import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/category_provider.dart';

class CategoryFilterItem extends StatelessWidget {
  const CategoryFilterItem({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    final CategoryProvider categoryProvider = Provider.of(context);
    bool isSelected = categoryProvider.isCategoryTab(categoryName);
    return InkWell(
      onTap: () {
        categoryProvider.changeSelectedCategory(categoryName);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff00a8e1) : const Color(0xffeaeaea),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          categoryName,
          style: TextStyle(
            fontSize: 11.sp,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
