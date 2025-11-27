import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../providers/overview_provider.dart';
import '../../widgets/info_grid_widget.dart';
import '../../widgets/profile_section_widget.dart';
import '../../widgets/stats_card_widget.dart';
import '../../widgets/order_list_widget.dart';
import '../../../../../core/constants/app_images.dart';

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
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Cards Grid
                const InfoGridWidget(),
                SizedBox(height: 3.h),
                // Stats Cards Row
                Row(
                  children: [
                    const Expanded(
                      child: StatsCardWidget(
                        title: 'Total Sales',
                        value: '20 K US',
                        icon: Images.totalSales,
                        iconColor: Color(0xFFFFB74D),
                        stats: [
                          {'label': 'Profits', 'value': '150 \$'},
                          {'label': 'Net Profit', 'value': '150\$'},
                        ],
                      ),
                    ),
                    SizedBox(width: 2.w),
                    const Expanded(
                      child: StatsCardWidget(
                        title: 'Total Orders',
                        value: '300',
                        icon: Images.totalOrders,
                        iconColor: Color(0xFF4CAF50),
                        stats: [
                          {'label': 'Cancelled Orders', 'value': '20'},
                          {'label': 'Active Orders', 'value': '10'},
                        ],
                      ),
                    ),
                    SizedBox(width: 2.w),
                    const Expanded(
                      child: StatsCardWidget(
                        title: 'Total Visits',
                        value: '420',
                        icon: Images.totalVisits,
                        iconColor: Color(0xFF2196F3),
                        stats: [
                          {'label': 'Last Visit', 'value': 'Aug 21, 2022'},
                          {'label': 'Spending Time / Day', 'value': '6 Hours'},
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),

                // Order List
                const OrderListWidget(),
              ],
            ),
          ),
          SizedBox(width: 2.w),
          // Profile Section
          const Expanded(flex: 2, child: ProfileSectionWidget()),
        ],
      ),
    );
  }
}
