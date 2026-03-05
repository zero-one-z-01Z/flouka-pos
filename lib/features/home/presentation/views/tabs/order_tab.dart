import 'package:flouka_pos/core/constants/app_lotties.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/widgets/empty_widget.dart';
import '../../../../../core/widgets/loading_animation_widget.dart';
import '../../../../orders/presentation/providers/order_details_provider.dart';
import '../../../../orders/presentation/providers/orders_provider.dart';
import '../../../../orders/presentation/widgets/order_card_widget.dart';
import '../../../../orders/presentation/widgets/order_tabs_with_idicator.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        children: [
          const CustomOrderTabsWidget(),
          SizedBox(height: 3.h),
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
      ),
    );
  }
}
