import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../orders/presentation/providers/order_details_provider.dart';
import '../../../../orders/presentation/widgets/order_card_widget.dart';
import '../../../../orders/presentation/widgets/order_tabs_with_idicator.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderDetailsProvider orderDetailsProvider = Provider.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Column(
        children: [
          const CustomOrderTabsWidget(),
          SizedBox(height: 3.h),
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2.w,
              mainAxisSpacing: 2.h,
              childAspectRatio: 1.15,
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  orderDetailsProvider.goToOrderDetailsView();
                },
                child: const OrderCardWidget(),
              );
            },
          ),
        ],
      ),
    );
  }
}
