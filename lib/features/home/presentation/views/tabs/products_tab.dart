import 'package:flouka_pos/core/constants/app_lotties.dart';
import 'package:flouka_pos/core/helper_function/prefs.dart';
import 'package:flouka_pos/core/widgets/empty_animation.dart';
import 'package:flouka_pos/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
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
    final productProvider = Provider.of<ProductsProvider>(context);
    final navProvider = Provider.of<HomeProvider>(context);
    productProvider.pagination();
    return RefreshIndicator(
      onRefresh: () => productProvider.refresh(),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          controller: productProvider.controller,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Builder(
            builder: (context) {
              if (productProvider.data == null) {
                return Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }else if (productProvider.data!.isEmpty) {
                return const EmptyAnimation(title: "", gif: Lotties.noSearch);
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),

                  // // Categories
                  // const CategoriesListWidget(),
                  SizedBox(height: 2.h),

                  // Products header + add button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LanguageProvider.translate('global', 'products'),
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      if(!(sharedPreferences.getBool('isStore') ?? false))
                      ButtonWidget(
                        onTap: () {
                          navProvider.setSelectedNavigation(
                            navProvider.navigationList.firstWhere(
                                  (nav) => nav.title == 'add_products',
                            ),
                          );
                        },
                        text: LanguageProvider.translate('buttons', 'add_products'),
                        width: 15.w,
                        height: 5.h,
                        borderRadius: 9.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  // Products Grid

                  Wrap(
                    spacing: 2.w,
                    runSpacing: 2.h,
                    children: List.generate(productProvider.data!.length, (index) {
                      final product = productProvider.data![index];
                      return ProductItemWidget(product: product);
                    }),
                  ),
                  SizedBox(height: 2.h),
                  if (productProvider.paginationStarted) const LoadingWidget(),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
