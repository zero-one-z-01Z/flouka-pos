import 'package:flouka_pos/core/constants/app_lotties.dart';
import 'package:flouka_pos/core/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../core/widgets/empty_widget.dart';
import '../../../../../core/widgets/loading_animation_widget.dart';
import '../../../../orders/presentation/providers/order_details_provider.dart';
import '../../../../orders/presentation/providers/orders_provider.dart';
import '../../../../orders/presentation/widgets/list_order_tabs_widget.dart';
import '../../../../orders/presentation/widgets/order_card_widget.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    ordersProvider.pagination();
    return RefreshIndicator(
      onRefresh: () => ordersProvider.refresh(),
      child: SingleChildScrollView(
        controller: ordersProvider.controller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          children: [
            SizedBox(height: 3.h),
            const ListOrderTabsWidget(),
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
                return SizedBox(
                  width: 100.w,
                  child: Wrap(
                    runSpacing: 2.h,spacing: 2.w,
                    children: List.generate(ordersProvider.data!.length,
                            (index) => OrderCardWidget(orderEntity: ordersProvider.data![index],withButton: true,)),
                  ),
                );
              },
            ),
            SizedBox(height: 3.h),
            if(ordersProvider.paginationStarted)const  LoadingWidget(),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}
