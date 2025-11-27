
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../features/home/presentation/providers/home_provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of(context);
    return Container(
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
    );
  }
}