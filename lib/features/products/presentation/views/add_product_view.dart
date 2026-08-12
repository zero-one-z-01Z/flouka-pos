import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/widgets/vendor/vendor_widgets.dart';
import 'package:flouka_pos/features/home/presentation/providers/home_provider.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/add_product_provider.dart';
import '../providers/add_variant_provider.dart';
import '../widgets/add_product_basic_details_section.dart';
import '../widgets/product_images_section.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  void _cancel(BuildContext context) {
    final home = Provider.of<HomeProvider>(context, listen: false);
    try {
      home.setSelectedNavigation(
        home.navigationList.firstWhere((e) => e.title == 'Products'),
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final addProductProvider = Provider.of<AddProductProvider>(context);
    final compact = Constants.isCompactShell(context);
    final publishLabel = LanguageProvider.translate(
      'buttons',
      addProductProvider.product != null ? 'update_product' : 'add_product',
    );

    return Scaffold(
      backgroundColor: AppColor.canvas,
      body: Form(
        key: addProductProvider.formKey,
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final stack = constraints.maxWidth < 720;
                  if (stack) {
                    return const SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AddProductBasicDetailsSection(),
                          SizedBox(height: 16),
                          ProductImagesSection(),
                        ],
                      ),
                    );
                  }
                  return const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(20, 16, 12, 24),
                          child: AddProductBasicDetailsSection(),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(12, 16, 20, 24),
                          child: ProductImagesSection(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                compact ? 16 : 20,
                12,
                compact ? 16 : 20,
                compact ? 16 : 18,
              ),
              decoration: const BoxDecoration(
                color: AppColor.surface,
                border: Border(top: BorderSide(color: AppColor.hairline)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (addProductProvider.product != null) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () {
                            Provider.of<AddVariantProvider>(
                              context,
                              listen: false,
                            ).goToAddVariantView(
                              id: '${addProductProvider.product?.category?.id}',
                            );
                          },
                          icon: const Icon(
                            Icons.tune_rounded,
                            size: 18,
                            color: AppColor.sidebar,
                          ),
                          label: Text(
                            LanguageProvider.translate(
                              'product',
                              'add_attributes',
                            ),
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w700,
                              color: AppColor.sidebar,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _cancel(context),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(52),
                              side: const BorderSide(color: AppColor.hairline),
                              foregroundColor: AppColor.ink,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              LanguageProvider.translate('buttons', 'cancel'),
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: VendorPrimaryCta(
                            label: publishLabel,
                            icon: Icons.check_rounded,
                            onTap: () => addProductProvider.publishProduct(),
                          ),
                        ),
                      ],
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
