import 'package:flouka_pos/core/config/app_color.dart';
import 'package:flouka_pos/core/constants/app_images.dart';
import 'package:flouka_pos/core/widgets/svg_widget.dart';
import 'package:flouka_pos/features/home/domain/entity/navigation_entity.dart';
import 'package:flouka_pos/features/home/presentation/providers/home_provider.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

/// Primary mobile bottom tabs: Accueil · Commandes · Produits · Reels · Plus
class VendorBottomNav extends StatelessWidget {
  const VendorBottomNav({super.key, required this.onPlusTap});

  final VoidCallback onPlusTap;

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final selected = home.selectedNavigation.title;
    final hasReels = home.navigationList.any((e) => e.title == 'video');
    final fourthTitle = hasReels ? 'video' : 'support';
    final fourthLabel = hasReels
        ? LanguageProvider.translate('navbar', 'video')
        : LanguageProvider.translate('navbar', 'support');
    final fourthSvg = hasReels ? Images.video : Images.tickets;
    final isPlusSelected =
        selected != 'Overview' &&
        selected != 'Orders' &&
        selected != 'Products' &&
        selected != fourthTitle;

    return Material(
      color: AppColor.surface.withValues(alpha: 0.94),
      elevation: 8,
      shadowColor: Colors.black26,
      child: SafeArea(
        top: false,
        child: Container(
          height: 64,
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColor.hairline)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              _Tab(
                label: LanguageProvider.translate('navbar', 'home'),
                icon: Icons.home_rounded,
                svg: Images.overView,
                selected: selected == 'Overview',
                onTap: () => _select(home, 'Overview'),
              ),
              _Tab(
                label: LanguageProvider.translate('navbar', 'orders'),
                icon: Icons.receipt_long_rounded,
                svg: Images.orders,
                selected: selected == 'Orders',
                onTap: () => _select(home, 'Orders'),
              ),
              _Tab(
                label: LanguageProvider.translate('navbar', 'products'),
                icon: Icons.inventory_2_rounded,
                svg: Images.products,
                selected: selected == 'Products',
                onTap: () => _select(home, 'Products'),
              ),
              _Tab(
                label: fourthLabel,
                icon: Icons.videocam_rounded,
                svg: fourthSvg,
                selected: selected == fourthTitle,
                onTap: () => _select(home, fourthTitle),
              ),
              _Tab(
                label: LanguageProvider.translate('navbar', 'plus'),
                icon: Icons.more_horiz_rounded,
                selected: isPlusSelected,
                onTap: onPlusTap,
                useIcon: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _select(HomeProvider home, String title) {
    try {
      final nav = home.navigationList.firstWhere((e) => e.title == title);
      home.setSelectedNavigation(nav);
    } catch (_) {}
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.svg,
    this.useIcon = false,
  });

  final String label;
  final IconData icon;
  final String? svg;
  final bool selected;
  final VoidCallback onTap;
  final bool useIcon;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColor.sidebar : AppColor.textMuted;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 64,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selected)
                Container(
                  width: 28,
                  height: 3,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: AppColor.gold,
                    borderRadius: BorderRadius.circular(2),
                  ),
                )
              else
                const SizedBox(height: 7),
              if (useIcon || svg == null)
                Icon(icon, size: 22, color: color)
              else
                SvgWidget(
                  svg: svg!,
                  width: 20,
                  height: 20,
                  color: color,
                ),
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Sheet listing secondary destinations (Stories, Wallet, Settings…).
class VendorPlusSheet extends StatelessWidget {
  const VendorPlusSheet({super.key});

  static const _plusTitles = [
    'add_products',
    'stories',
    'offers',
    'wallet',
    'withdraw',
    'vendor_stores',
    'coupons',
    'support',
    'Settings',
  ];

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const VendorPlusSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
    final items = home.navigationList
        .where((e) => _plusTitles.contains(e.title))
        .toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColor.hairline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              LanguageProvider.translate('navbar', 'plus'),
              style: GoogleFonts.bricolageGrotesque(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColor.ink,
              ),
            ),
            const SizedBox(height: 12),
            ...items.map((item) => _PlusTile(item: item)),
          ],
        ),
      ),
    );
  }
}

class _PlusTile extends StatelessWidget {
  const _PlusTile({required this.item});

  final NavigationEntity item;

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context, listen: false);
    final selected = home.isSelected(item);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: selected ? AppColor.gold : AppColor.canvas,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.hairline),
        ),
        alignment: Alignment.center,
        child: SvgWidget(
          svg: item.svgImage,
          width: 18,
          height: 18,
          color: AppColor.sidebar,
        ),
      ),
      title: Text(
        LanguageProvider.translate('navbar', item.title.toLowerCase()),
        style: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: AppColor.ink,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColor.textMuted),
      onTap: () {
        Navigator.of(context).pop();
        home.setSelectedNavigation(item);
      },
    );
  }
}
