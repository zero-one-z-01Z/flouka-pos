import 'package:flouka_pos/core/widgets/list_text_field_widget.dart';
import 'package:flouka_pos/core/widgets/validation_widget.dart';
import 'package:flouka_pos/core/widgets/vendor/vendor_widgets.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/products/presentation/providers/add_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/widgets/upload_multi_image_widget.dart';
import '../providers/add_variant_provider.dart';
import '../widgets/variant_widget.dart';

class AddVariantView extends StatelessWidget {
  const AddVariantView({super.key});

  @override
  Widget build(BuildContext context) {
    final AddVariantProvider addVariantProvider = Provider.of(context);
    final AddProductProvider addProductProvider = Provider.of(context);
    final compact = MediaQuery.sizeOf(context).width < 720;
    final editing = addVariantProvider.variant != null;

    return Scaffold(
      backgroundColor: AppColor.canvas,
      appBar: AppBar(
        backgroundColor: AppColor.surface,
        foregroundColor: AppColor.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColor.ink),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          LanguageProvider.translate(
            'global',
            editing ? 'edit_variant' : 'add_variant',
          ),
          style: GoogleFonts.bricolageGrotesque(
            fontWeight: FontWeight.w800,
            color: AppColor.ink,
          ),
        ),
      ),
      body: Form(
        key: addVariantProvider.formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  compact ? 16 : 24,
                  16,
                  compact ? 16 : 24,
                  24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(compact ? 16 : 20),
                      decoration: BoxDecoration(
                        color: AppColor.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColor.hairline),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LanguageProvider.translate('product', 'variant_details'),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColor.textMuted,
                              letterSpacing: 0.4,
                            ),
                          ),
                          const SizedBox(height: 14),
                          if (compact) ...[
                            ListTextFieldWidget(
                              inputs: addVariantProvider.variantInputs,
                              borderRadius: 12,
                            ),
                            const SizedBox(height: 16),
                            _VariantImagesAndAttributes(
                              addVariantProvider: addVariantProvider,
                            ),
                          ] else
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ListTextFieldWidget(
                                    inputs: addVariantProvider.variantInputs,
                                    borderRadius: 12,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: _VariantImagesAndAttributes(
                                    addVariantProvider: addVariantProvider,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    if (addProductProvider.product != null &&
                        addProductProvider.product!.variants.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      VendorSectionHeader(
                        title: LanguageProvider.translate('global', 'variants'),
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(
                        addProductProvider.product!.variants.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: VariantWidget(
                            variant:
                                addProductProvider.product!.variants[index],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                compact ? 16 : 24,
                12,
                compact ? 16 : 24,
                compact ? 16 : 18,
              ),
              decoration: const BoxDecoration(
                color: AppColor.surface,
                border: Border(top: BorderSide(color: AppColor.hairline)),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    if (editing) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => addVariantProvider.reset(),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            side: const BorderSide(color: AppColor.hairline),
                            foregroundColor: AppColor.ink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            LanguageProvider.translate(
                              'buttons',
                              'cancel_selection',
                            ),
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      flex: 2,
                      child: VendorPrimaryCta(
                        label: LanguageProvider.translate(
                          'buttons',
                          editing ? 'update_variant' : 'add_variant',
                        ),
                        onTap: () {
                          if (addVariantProvider.formKey.currentState!
                              .validate()) {
                            if (editing) {
                              addVariantProvider.updateVariant();
                            } else {
                              addVariantProvider.createVariant();
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VariantImagesAndAttributes extends StatelessWidget {
  const _VariantImagesAndAttributes({required this.addVariantProvider});

  final AddVariantProvider addVariantProvider;

  Color? _hexColor(String? hex) {
    if (hex == null || hex.isEmpty) return null;
    var h = hex.replaceAll('#', '').trim();
    if (h.length == 6) h = 'FF$h';
    final v = int.tryParse(h, radix: 16);
    return v == null ? null : Color(v);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LanguageProvider.translate('product', 'upload_variant_images'),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColor.ink,
          ),
        ),
        const SizedBox(height: 10),
        UploadMultiImageWidget(
          images: addVariantProvider.productImages,
          count: 5,
          deleteImage: (index) {
            addVariantProvider.deleteImage(index);
          },
          imagesList: (images) {
            addVariantProvider.addToImages(images);
          },
          title: 'upload_product_images',
          translationSection: 'product',
        ),
        const SizedBox(height: 18),
        ...List.generate(addVariantProvider.attributes.length, (index) {
          final attribute = addVariantProvider.attributes[index];
          final title = attribute['title']?.toString() ?? '';
          final children = (attribute['children'] as List?) ?? const [];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColor.ink,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(children.length, (i) {
                    final child = Map<String, dynamic>.from(children[i] as Map);
                    final selected = child['active'] == true;
                    final name = child['name']?.toString() ?? '';
                    final swatch = _hexColor(child['hex']?.toString());
                    return Material(
                      color: selected ? AppColor.sidebar : AppColor.canvas,
                      borderRadius: BorderRadius.circular(22),
                      child: InkWell(
                        onTap: () => addVariantProvider.setLabelValue(
                          attribute,
                          child,
                        ),
                        borderRadius: BorderRadius.circular(22),
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 40),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: selected
                                  ? AppColor.gold
                                  : AppColor.hairline,
                              width: selected ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (swatch != null) ...[
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: swatch,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                              Text(
                                name,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: selected
                                      ? AppColor.gold
                                      : AppColor.ink,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        }),
        ValidationWidget(
          conditions: [
            {
              'value': !addVariantProvider.isAllAttributesSelected,
              'text': LanguageProvider.translate('product', 'select_all'),
            }
          ],
        ),
      ],
    );
  }
}
