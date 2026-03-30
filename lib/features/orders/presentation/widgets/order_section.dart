import 'package:flouka_pos/core/widgets/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/app_lotties.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../providers/orders_provider.dart';
import 'list_order_tabs_widget.dart';
import 'order_card_widget.dart';

class OrderSection extends StatelessWidget {
  const OrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order List',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            // Tabs
            const ListOrderTabsWidget(),
          ],
        ),
        SizedBox(height: 4.h),
        // Order Cards
        Builder(
          builder: (context) {
            if (Provider.of<OrdersProvider>(context).data == null) {
              return const Center(
                child: LoadingAnimationWidget(gif: Lotties.loading),
              );
            }
            if (Provider.of<OrdersProvider>(context).data!.isEmpty) {
              return const Center(
                child: EmptyWidget(image: Lotties.noOrders, title: ''),
              );
            }
            return GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.w,
                mainAxisSpacing: 2.h,
                childAspectRatio: 1.15,
              ),
              itemCount: ordersProvider.data!.length,
              itemBuilder: (context, index) {
                return OrderCardWidget(orderEntity: ordersProvider.data![index]);
              },
            );
          },
        ),
      ],
    );
  }
}
