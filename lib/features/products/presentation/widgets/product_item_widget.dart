import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/svg_widget.dart';
import '../../domain/entities/product_entity.dart';
import '../providers/product_provider.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;
  final int index;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProductItemWidget({
    super.key,
    required this.product,
    required this.index,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context, listen: false);

    return GestureDetector(
      onTap: () => provider.openPreview(product),
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
              decoration: BoxDecoration(
                color: const Color(0xfff8f7fa),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(product.imagePath, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              product.name,
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
                if (product.oldPrice != null) ...[
                  SizedBox(width: 2.w),
                  Text(
                    "\$${product.oldPrice}",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColor.tertiaryColor,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ]
              ],
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 14),
                SizedBox(width: 1.w),
                Text(
                  product.rating.toString(),
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                Consumer<ProductProvider>(
                  builder: (_, provider, __) {
                    return FlutterSwitch(
                      width: 5.w,
                      height: 3.h,
                      toggleSize: 3.h,
                      value: provider.products[index].isActive,
                      borderRadius: 20.sp,
                      padding: 2.sp,
                      activeColor: Colors.green,
                      inactiveColor: Colors.red,
                      showOnOff: true,
                      activeText: LanguageProvider.translate('global', 'active'),
                      inactiveText: LanguageProvider.translate('global', 'inactive'),
                      activeTextColor: Colors.white,
                      inactiveTextColor: Colors.white,
                      valueFontSize: 9.sp,
                      onToggle: (val) => provider.toggleProductActive(index, val),
                    );
                  },
                ),
                SizedBox(width: 1.w),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: SvgWidget(svg: Images.edit, width: 13.sp, height: 13.sp, color: Colors.black),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: SvgWidget(svg: Images.delete, width: 13.sp, height: 13.sp, color: Colors.black),
                      onPressed: onDelete,
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
