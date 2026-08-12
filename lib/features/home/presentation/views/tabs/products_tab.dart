import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/constants/app_lotties.dart';
import 'package:flouka_pos/core/constants/constants.dart';
import 'package:flouka_pos/core/helper_function/prefs.dart';
import 'package:flouka_pos/core/widgets/empty_animation.dart';
import 'package:flouka_pos/core/widgets/loading_widget.dart';
import 'package:flouka_pos/core/widgets/vendor/vendor_widgets.dart';
import 'package:flouka_pos/features/home/presentation/providers/home_provider.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../products/presentation/providers/product_provider.dart';
import '../../../../products/presentation/widgets/product_item_widget.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  void _goAdd(BuildContext context) {
    final navProvider = Provider.of<HomeProvider>(context, listen: false);
    try {
      navProvider.setSelectedNavigation(
        navProvider.navigationList.firstWhere(
          (nav) => nav.title == 'add_products',
        ),
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    productProvider.pagination();
    final compact = Constants.isCompactShell(context);
    final isStore = sharedPreferences.getBool('isStore') ?? false;

    return Scaffold(
      backgroundColor: AppColor.canvas,
      floatingActionButton: (!isStore && compact)
          ? FloatingActionButton.extended(
              onPressed: () => _goAdd(context),
              backgroundColor: AppColor.gold,
              foregroundColor: AppColor.ink,
              icon: const Icon(Icons.add_rounded),
              label: Text(
                LanguageProvider.translate('buttons', 'add_product'),
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            )
          : null,
      body: RefreshIndicator(
        color: AppColor.sidebar,
        onRefresh: () => productProvider.refresh(),
        child: SingleChildScrollView(
          controller: productProvider.controller,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            compact ? 16 : 20,
            16,
            compact ? 16 : 20,
            compact ? 88 : 28,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      LanguageProvider.translate('global', 'products'),
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: compact ? 22 : 18,
                        fontWeight: FontWeight.w800,
                        color: AppColor.ink,
                      ),
                    ),
                  ),
                  if (!isStore && !compact)
                    SizedBox(
                      width: 160,
                      child: VendorPrimaryCta(
                        label: LanguageProvider.translate(
                          'buttons',
                          'add_product',
                        ),
                        icon: Icons.add_rounded,
                        onTap: () => _goAdd(context),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (context) {
                  if (productProvider.data == null) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.sidebar,
                        ),
                      ),
                    );
                  }
                  if (productProvider.data!.isEmpty) {
                    return const EmptyAnimation(
                      title: '',
                      gif: Lotties.noSearch,
                    );
                  }
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final cols = constraints.maxWidth > 1100
                          ? 3
                          : constraints.maxWidth > 560
                              ? 2
                              : 1;
                      const gap = 12.0;
                      final w = cols == 1
                          ? constraints.maxWidth
                          : (constraints.maxWidth - gap * (cols - 1)) / cols;
                      return Column(
                        children: [
                          Wrap(
                            spacing: gap,
                            runSpacing: gap,
                            children: productProvider.data!
                                .map(
                                  (product) => SizedBox(
                                    width: w,
                                    child: ProductItemWidget(product: product),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(height: 16),
                          if (productProvider.paginationStarted)
                            const LoadingWidget(),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
