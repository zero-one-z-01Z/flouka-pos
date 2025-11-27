import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../providers/overview_provider.dart';
import '../../widgets/info_grid_widget.dart';
import '../../widgets/profile_section_widget.dart';
import '../../../../orders/presentation/widgets/order_section.dart';
import '../../widgets/status_row_widget.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final OverviewProvider overviewProvider = Provider.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(3.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const InfoGridWidget(),
                          SizedBox(height: 2.w),
                          const StatusRowWidget(),
                        ],
                      ),
                    ),
                    SizedBox(width: 1.w),
                    const ProfileSectionWidget(),
                  ],
                ),
                SizedBox(height: 2.h),
                const OrderSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
