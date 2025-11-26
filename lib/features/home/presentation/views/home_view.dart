import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/home_provider.dart';
import '../widgets/navigation_rail_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fd),
      body: Row(
        children: [
          const NavigationRailWidget(),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 4.h, bottom: 2.h, left: 2.w),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Color(0xfff6f6f6))),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: () {
                          homeProvider.toggleDrawer();
                        },
                        child: const Icon(Icons.menu),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
