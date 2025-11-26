import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/widgets/logo_widget.dart';
import '../providers/home_provider.dart';
import 'navigation_item_widget.dart';

class NavigationRailWidget extends StatelessWidget {
  const NavigationRailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: homeProvider.isDrawerOpen ? 17.w : 0,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.centerLeft,
          maxWidth: 17.w,
          child: Container(
            width: 17.w,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(right: BorderSide(color: Color(0xfff6f6f6))),
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: homeProvider.isDrawerOpen ? 1.0 : 0.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 5.h),
                  LogoWidget(width: 10.w),
                  SizedBox(height: 5.h),
                  ...List.generate(
                    homeProvider.navigationList.length,
                    (index) => NavigationItemWidget(
                      navigationEntity: homeProvider.navigationList[index],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
