import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/config/app_color.dart';
import '../../../../core/widgets/svg_widget.dart';
import '../../domain/entity/navigation_entity.dart';
import '../../../../features/language/presentation/provider/language_provider.dart';
import '../providers/home_provider.dart';

class NavigationItemWidget extends StatelessWidget {
  const NavigationItemWidget({super.key, required this.navigationEntity});
  final NavigationEntity navigationEntity;

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    final isSelected = homeProvider.isSelected(navigationEntity);
    final title = navigationEntity.title.toLowerCase();
    final showOrdersBadge = title == 'orders';

    return InkWell(
      onTap: () {
        homeProvider.setSelectedNavigation(navigationEntity);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 38,
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.navSelected : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SvgWidget(
              svg: navigationEntity.svgImage,
              width: 18,
              height: 18,
              color: isSelected ? Colors.white : AppColor.textMuted,
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                LanguageProvider.translate(
                  'navbar',
                  title,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xff5B6472),
                ),
              ),
            ),
            if (showOrdersBadge)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.26)
                      : const Color(0xffFFEDD6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '3',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : const Color(0xffB5810F),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
