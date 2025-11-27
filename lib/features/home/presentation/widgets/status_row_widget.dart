import 'package:flouka_pos/features/home/presentation/widgets/stats_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/overview_provider.dart';

class StatusRowWidget extends StatelessWidget {
  const StatusRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final OverviewProvider overviewProvider = Provider.of(context);
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            spreadRadius: -5,
            offset: Offset(0, 6),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Row(
        spacing: 2.w,
        children: List.generate(
          overviewProvider.statsCards.length,
          (index) => Expanded(
            child: StatsCardWidget(entity: overviewProvider.statsCards[index]),
          ),
        ),
      ),
    );
  }
}
