import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/config/app_color.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/home_provider.dart';
import 'navigation_item_widget.dart';

class NavigationRailWidget extends StatelessWidget {
  const NavigationRailWidget({super.key});

  String _initials(String? name) {
    if (name == null || name.trim().isEmpty) return 'FL';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts.first.substring(0, parts.first.length.clamp(0, 2)).toUpperCase();
    }
    return ('${parts.first[0]}${parts.last[0]}').toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    final AuthProvider authProvider = Provider.of(context);
    final storeName = authProvider.userEntity?.name ?? 'Store';
    final isActive = authProvider.userEntity?.active ?? false;

    return Container(
      width: 224,
      decoration: const BoxDecoration(
        color: AppColor.surface,
        border: Border(right: BorderSide(color: AppColor.hairline, width: 1)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(14, 18, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 6, 16),
              child: Image.asset(
                'assets/brand/flouka_lockup_navy.png',
                height: 34,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColor.canvas,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: AppColor.avatarBgs[0],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.hairline),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _initials(storeName),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColor.textPrimary,
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
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          isActive ? 'Accepting orders' : 'Paused',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: isActive
                                ? const Color(0xff4CAF50)
                                : AppColor.textFaint,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.unfold_more, size: 14, color: AppColor.textFaint),
                ],
              ),
            ),
            const SizedBox(height: 18),
            ...List.generate(
              homeProvider.navigationList.length,
              (index) {
                final item = homeProvider.navigationList[index];
                final title = item.title.toLowerCase();
                final hasDividerAfter =
                    title == 'products' || title == 'coupons';

                return Column(
                  children: [
                    NavigationItemWidget(navigationEntity: item),
                    if (hasDividerAfter)
                      Container(
                        height: 1,
                        color: AppColor.hairlineSoft,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                      ),
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
