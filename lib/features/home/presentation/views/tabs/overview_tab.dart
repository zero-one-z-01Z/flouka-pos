import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/widgets/vendor/vendor_widgets.dart';
import 'package:flouka_pos/features/auth/presentation/providers/auth_provider.dart';
import 'package:flouka_pos/features/home/presentation/providers/home_provider.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/orders/presentation/providers/orders_provider.dart';
import 'package:flouka_pos/features/products/presentation/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  void _go(HomeProvider home, String title) {
    try {
      home.setSelectedNavigation(
        home.navigationList.firstWhere((e) => e.title == title),
      );
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final orders = Provider.of<OrdersProvider>(context);
    final products = Provider.of<ProductsProvider>(context);
    final home = Provider.of<HomeProvider>(context, listen: false);

    final sales = auth.userEntity?.vendorStatistics?.sales?.total ?? 0;
    final activeOrders =
        auth.userEntity?.vendorStatistics?.orders?.active ?? 0;
    final wallet =
        auth.userEntity?.vendorStatistics?.wallet?.wallet ?? 0;
    final pending = orders.homeOrders?.length ?? 0;
    final productCount = products.data?.length ??
        auth.userEntity?.productsCount ??
        0;
    final pendingList = (orders.homeOrders ?? []).take(5).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (auth.userEntity?.active != true) ...[
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColor.gold.withValues(alpha: 0.45)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LanguageProvider.translate('auth', 'under_review'),
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      color: AppColor.sidebar,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    LanguageProvider.translate('auth', 'boutique_under_review'),
                    style: GoogleFonts.lato(
                      fontSize: 12,
                      height: 1.35,
                      color: AppColor.ink.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = constraints.maxWidth > 900
                  ? 4
                  : constraints.maxWidth < 420
                      ? 1
                      : 2;
              final gap = 12.0;
              final w = cols == 1
                  ? constraints.maxWidth
                  : (constraints.maxWidth - gap * (cols - 1)) / cols;
              final cards = [
                VendorKpiChip(
                  label: 'CA DU JOUR',
                  value: '${sales.toStringAsFixed(0)} DT',
                  hint: LanguageProvider.translate('global', 'total_sales'),
                ),
                VendorKpiChip(
                  label: 'À TRAITER',
                  value: '$pending',
                  hint: pending > 0
                      ? '$pending en attente'
                      : 'aucune en attente',
                  onTap: () => _go(home, 'Orders'),
                ),
                VendorKpiChip(
                  label: 'COMMANDES ACTIVES',
                  value: '$activeOrders',
                  hint: LanguageProvider.translate('navbar', 'orders'),
                ),
                VendorKpiChip(
                  label: 'DISPONIBLE',
                  value: '${wallet.toStringAsFixed(0)} DT',
                  hint: '$productCount produits',
                  onTap: () => _go(home, 'wallet'),
                ),
              ];
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: cards
                    .map((c) => SizedBox(width: w, child: c))
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              VendorQuickAction(
                label: '+ Produit',
                icon: Icons.add_rounded,
                filled: true,
                onTap: () => _go(home, 'add_products'),
              ),
              VendorQuickAction(
                label: 'Reel',
                icon: Icons.videocam_outlined,
                onTap: () => _go(home, 'video'),
              ),
              VendorQuickAction(
                label: 'Story',
                icon: Icons.auto_stories_outlined,
                onTap: () => _go(home, 'stories'),
              ),
            ],
          ),
          const SizedBox(height: 22),
          VendorSectionHeader(
            title: 'Dernières commandes',
            trailing: TextButton(
              onPressed: () => _go(home, 'Orders'),
              child: Text(
                'Tout voir',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w700,
                  color: AppColor.sidebarAccent,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (pendingList.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColor.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColor.hairline),
              ),
              child: Text(
                'Aucune commande en attente',
                style: GoogleFonts.lato(color: AppColor.textMuted),
              ),
            )
          else
            ...pendingList.map((o) {
              final status = o.vendorOrders.status.text;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () => _go(home, 'Orders'),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.all(14),
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
                                '#FLK-${o.id} · ${o.user?.name ?? 'Client'}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: AppColor.ink,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${o.paymentMethod} · ${o.address.address}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: AppColor.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${o.total} DT',
                              style: GoogleFonts.bricolageGrotesque(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: AppColor.ink,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColor.canvas,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                LanguageProvider.translate('global', status)
                                    .toUpperCase(),
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.sidebar,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
