import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../helper_function/kyc.dart';
import '../../features/home/presentation/providers/home_provider.dart';
import '../../features/language/presentation/provider/language_provider.dart';
import '../../features/language/presentation/widget/language_widget.dart';
import '../../features/notification/presentation/provider/notifications_provider.dart';
import '../../features/orders/presentation/providers/orders_provider.dart';
import '../config/app_color.dart';
import '../constants/app_images.dart';
import '../constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.showMenu = false, this.compact});

  final bool showMenu;
  final bool? compact;

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    final OrdersProvider ordersProvider = Provider.of(context);
    final AuthProvider authProvider = Provider.of(context);
    final isCompact = compact ?? showMenu || Constants.isCompactShell(context);
    final name = authProvider.userEntity?.name ?? '';
    final title = LanguageProvider.translate(
      'navbar',
      homeProvider.selectedNavigation.title.toLowerCase(),
    );
    final waitingCount = ordersProvider.homeOrders?.length ?? 0;
    final isOverview =
        homeProvider.selectedNavigation.title.toLowerCase() == 'overview';

    return Container(
      height: isCompact ? 64 : 72,
      decoration: const BoxDecoration(
        color: AppColor.surface,
        border: Border(bottom: BorderSide(color: AppColor.hairline, width: 1)),
      ),
      padding: EdgeInsets.symmetric(horizontal: isCompact ? 12 : 24),
      child: Row(
        children: [
          if (showMenu) ...[
            IconButton(
              tooltip: 'Menu',
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu_rounded, color: AppColor.ink),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            ),
            const SizedBox(width: 4),
          ],
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isOverview && name.isNotEmpty ? 'Bonjour, $name' : title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.bricolageGrotesque(
                    fontSize: isCompact ? 18 : 18,
                    fontWeight: FontWeight.w700,
                    color: AppColor.ink,
                    letterSpacing: -0.3,
                  ),
                ),
                if (!isCompact || !isOverview) ...[
                  const SizedBox(height: 2),
                  Text(
                    '$waitingCount commandes · $title',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.lato(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textMuted,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (!isCompact) ...[
            const SizedBox(width: 14),
            Container(
              width: 260,
              height: 42,
              decoration: BoxDecoration(
                color: AppColor.canvas,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColor.hairline),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 16, color: AppColor.textMuted),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Commande, produit, client…',
                        hintStyle: GoogleFonts.lato(
                          fontSize: 12,
                          color: AppColor.textFaint,
                        ),
                      ),
                      style: GoogleFonts.lato(fontSize: 12, color: AppColor.ink),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(width: 10),
          if (!isCompact) const LanguageWidget(),
          if (!isCompact) const SizedBox(width: 8),
          InkWell(
            onTap: () {
              NotificationProvider notificationProvider =
                  Provider.of(context, listen: false);
              notificationProvider.goToNotificationPage();
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColor.canvas,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.hairline),
              ),
              alignment: Alignment.center,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    Images.appBarNotification,
                    width: 17,
                    height: 17,
                    colorFilter: const ColorFilter.mode(
                      AppColor.ink,
                      BlendMode.srcIn,
                    ),
                  ),
                  if (!isKycDocsComplete(authProvider.userEntity))
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2C14E),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
