import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/features/products/presentation/providers/add_variant_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../language/presentation/provider/language_provider.dart';
import '../../domain/entity/variant_entity.dart';

class VariantWidget extends StatelessWidget {
  const VariantWidget({super.key, required this.variant});
  final VariantEntity variant;

  @override
  Widget build(BuildContext context) {
    final addVariantProvider = Provider.of<AddVariantProvider>(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
      decoration: BoxDecoration(
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.hairline),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  variant.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColor.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'SKU ${variant.sku.isEmpty ? '—' : variant.sku} · ${variant.price} DT'
                  '${(variant.offerPrice != null && variant.offerPrice! > 0) ? ' · promo ${variant.offerPrice} DT' : ''}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    color: AppColor.textMuted,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: LanguageProvider.translate('buttons', 'edit'),
            onPressed: () =>
                addVariantProvider.selectToEdit(variant: variant),
            icon: const Icon(Icons.edit_rounded, color: AppColor.sidebar),
          ),
          IconButton(
            tooltip: LanguageProvider.translate('buttons', 'delete'),
            onPressed: () =>
                addVariantProvider.deleteVariantDialog(id: variant.id),
            icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFF8E2A20)),
          ),
        ],
      ),
    );
  }
}
