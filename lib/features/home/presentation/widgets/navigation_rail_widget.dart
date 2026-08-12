import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/constants/app_images.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../language/presentation/provider/language_provider.dart';
import '../providers/home_provider.dart';
import 'navigation_item_widget.dart';

class NavigationRailWidget extends StatelessWidget {
  const NavigationRailWidget({super.key, this.asDrawer = false});

  /// Full-width when hosted inside [Drawer]; fixed 264px in tablet rail.
  final bool asDrawer;

  String _initials(String? name) {
    if (name == null || name.trim().isEmpty) return 'FL';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts.first.substring(0, parts.first.length.clamp(0, 2)).toUpperCase();
    }
    return ('${parts.first[0]}${parts.last[0]}').toUpperCase();
  }

  /// Section label before first item of that group (keys unchanged).
  static String? sectionFor(String title) {
    switch (title.toLowerCase()) {
      case 'overview':
      case 'orders':
        return 'PILOTAGE';
      case 'products':
      case 'add_products':
      case 'video':
      case 'stories':
      case 'offers':
        return 'CATALOGUE';
      case 'wallet':
      case 'withdraw':
        return 'ARGENT';
      case 'vendor_stores':
      case 'coupons':
      case 'support':
        return 'BOUTIQUE';
      case 'settings':
        return 'COMPTE';
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    final AuthProvider authProvider = Provider.of(context);
    final storeName = authProvider.userEntity?.name ?? 'Store';
    final isActive = authProvider.userEntity?.active ?? false;

    return Container(
      width: asDrawer ? double.infinity : 264,
      decoration: const BoxDecoration(
        color: AppColor.sidebar,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 22, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 6, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    Images.floukaLogoReverse,
                    height: 38,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'VENDOR',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColor.gold,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF14523E),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColor.gold.withValues(alpha: 0.18)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColor.gold,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _initials(storeName),
                      style: GoogleFonts.lato(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppColor.ink,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          storeName,
                          style: GoogleFonts.lato(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColor.surfaceElevated,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isActive
                              ? 'Actif'
                              : LanguageProvider.translate('auth', 'under_review'),
                          style: GoogleFonts.lato(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: isActive
                                ? const Color(0xffDCE9E4)
                                : AppColor.gold.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            ...List.generate(
              homeProvider.navigationList.length,
              (index) {
                final item = homeProvider.navigationList[index];
                final section = sectionFor(item.title);
                final prev = index > 0
                    ? sectionFor(homeProvider.navigationList[index - 1].title)
                    : null;
                final showSection = section != null && section != prev;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showSection) ...[
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                          top: index == 0 ? 0 : 14,
                          bottom: 6,
                        ),
                        child: Text(
                          section,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.6,
                            color: const Color(0xFF6E9581),
                          ),
                        ),
                      ),
                    ],
                    NavigationItemWidget(navigationEntity: item),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
