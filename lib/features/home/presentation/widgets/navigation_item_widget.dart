import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/widgets/svg_widget.dart';
import '../../domain/entity/navigation_entity.dart';
import '../providers/home_provider.dart';

class NavigationItemWidget extends StatelessWidget {
  const NavigationItemWidget({super.key, required this.navigationEntity});
  final NavigationEntity navigationEntity;
  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    bool isSelected = homeProvider.isSelected(navigationEntity);
    return InkWell(
      onTap: () {
        homeProvider.setSelectedNavigation(navigationEntity);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 1.h),
        padding: EdgeInsets.symmetric(vertical: 1.h),
        width: 17.w,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffc7f1ff) : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 1.w,
          children: [
            SizedBox(width: 2.w),
            SvgWidget(svg: navigationEntity.svgImage),
            Text(
              LanguageProvider.translate(
                'navbar',
                navigationEntity.title.toLowerCase(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
