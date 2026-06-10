import 'package:flouka_pos/core/helper_function/prefs.dart';
import 'package:flouka_pos/features/products/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/svg_widget.dart';
import '../providers/add_product_provider.dart';
import '../providers/product_provider.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';

import '../providers/store_operation_provider.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductItemWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    final addProductProvider = Provider.of<AddProductProvider>(context, listen: false);
    bool isStore = sharedPreferences.getBool('isStore') ?? false;
    return GestureDetector(
      onTap: () {
        if(isStore){
          Provider.of<StoreOperationProvider>(context, listen: false).showAddWidget(product: product);
        }
      },
      child: Container(
        width: 12.w,
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(1.w),
        decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 10.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xfff8f7fa),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(product.image??'', fit: BoxFit.contain,errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              product.title.toString(),
              style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 0.5.h),
            Row(
              children: [
                Text(
                  "\$${product.price}",
                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600),
                ),
                if (product.price != null) ...[
                  SizedBox(width: 2.w),
                  Text(
                    "\$${product.price}",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColor.tertiaryColor,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ]
              ],
            ),
            SizedBox(height: 1.h),
            if(!isStore)
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 1.w),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: SvgWidget(svg: Images.edit, width: 13.sp, height: 13.sp, color: AppColor.primaryColor),
                      onPressed: () {
                        addProductProvider.getProductVendorDetails(id: product.id);
                      },
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: SvgWidget(svg: Images.delete, width: 13.sp, height: 13.sp, color: Colors.red),
                      onPressed: (){
                        addProductProvider.deleteProductDialog(id: product.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
