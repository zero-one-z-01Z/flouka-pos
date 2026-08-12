import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/widgets/svg_widget.dart';
import '../../domain/entity/navigation_entity.dart';
import '../../../../features/language/presentation/provider/language_provider.dart';
import '../../../orders/presentation/providers/orders_provider.dart';
import '../providers/home_provider.dart';

class NavigationItemWidget extends StatelessWidget {
  const NavigationItemWidget({super.key, required this.navigationEntity});
  final NavigationEntity navigationEntity;

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    final OrdersProvider ordersProvider = Provider.of(context);
    final isSelected = homeProvider.isSelected(navigationEntity);
    final title = navigationEntity.title.toLowerCase();
    final ordersBadgeCount = ordersProvider.homeOrders?.length ??
        (ordersProvider.data?.length ?? 0);
    final showOrdersBadge = title == 'orders' && ordersBadgeCount > 0;

    return InkWell(
      onTap: () {
        homeProvider.setSelectedNavigation(navigationEntity);
        final scaffold = Scaffold.maybeOf(context);
        if (scaffold?.isDrawerOpen ?? false) {
          scaffold!.closeDrawer();
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 38,
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.gold : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: isSelected ? AppColor.sidebar : const Color(0xFF3D6E58),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 11),
            SvgWidget(
              svg: navigationEntity.svgImage,
              width: 16,
              height: 16,
              color: isSelected
                  ? AppColor.sidebar
                  : Colors.white.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                LanguageProvider.translate('navbar', title),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? AppColor.sidebar
                      : const Color(0xFFC3D6CB),
                ),
              ),
            ),
            if (showOrdersBadge)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                decoration: BoxDecoration(
                  color: AppColor.gold,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$ordersBadgeCount',
                  style: GoogleFonts.lato(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColor.ink,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
