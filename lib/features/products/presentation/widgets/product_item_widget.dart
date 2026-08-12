import 'package:flouka_pos/core/helper_function/prefs.dart';
import 'package:flouka_pos/features/products/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/svg_widget.dart';
import '../providers/add_product_provider.dart';
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
    final addProductProvider =
        Provider.of<AddProductProvider>(context, listen: false);
    final isStore = sharedPreferences.getBool('isStore') ?? false;
    return GestureDetector(
      onTap: () {
        if (isStore) {
          Provider.of<StoreOperationProvider>(context, listen: false)
              .showAddWidget(product: product);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColor.hairline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.canvas,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.image ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: AppColor.textMuted,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.title.toString(),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColor.ink,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              '${LanguageProvider.translate('global', 'currency')} ${product.price}',
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: AppColor.ink,
              ),
            ),
            if (!isStore) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    icon: const SvgWidget(
                      svg: Images.edit,
                      width: 16,
                      height: 16,
                      color: AppColor.sidebar,
                    ),
                    onPressed: () {
                      addProductProvider.getProductVendorDetails(
                        id: product.id,
                      );
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    icon: const SvgWidget(
                      svg: Images.delete,
                      width: 16,
                      height: 16,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      addProductProvider.deleteProductDialog(id: product.id);
                    },
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
