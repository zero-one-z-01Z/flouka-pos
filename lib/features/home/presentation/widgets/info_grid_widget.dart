import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/overview_provider.dart';
import 'info_card_widget.dart';

class InfoGridWidget extends StatelessWidget {
  const InfoGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final OverviewProvider overviewProvider = Provider.of(context);
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 9,
            spreadRadius: -5,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: GridView.count(
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 1.w,
        mainAxisSpacing: 1.h,
        childAspectRatio: 5,
        children: List.generate(
          overviewProvider.infoCards.length,
          (index) =>
              InfoCardWidget(infoCardEntity: overviewProvider.infoCards[index]),
        ),
      ),
    );
  }
}
