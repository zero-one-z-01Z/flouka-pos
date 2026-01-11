import 'package:flouka_pos/core/widgets/price_details_widget.dart';
import 'package:flouka_pos/features/orders/presentation/widgets/delivery_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../widgets/item_summary_section.dart';
import '../widgets/order_card_widget.dart';
import '../widgets/order_details_header.dart';
import '../widgets/update_order_wiidget.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fd),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          children: [
            SizedBox(height: 5.h),
            const OrderDetailsHeader(),
            SizedBox(height: 2.h),
            Container(
              width: 100.w,
              height: .1.h,
              decoration: BoxDecoration(
                color: const Color(0xffb7b7b7),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      spacing: 2.w,
                      children: [
                        const Expanded(child: OrderCardWidget()),
                        const Expanded(child: DeliveryAddressWidget()),
                        const Expanded(child: PriceDetailesList()),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Wrap(
                    spacing: 1.w,
                    runSpacing: 1.h,
                    children: List.generate(
                      2,
                      (index) => const UpdateOrderWiidget(),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  const ItemSummarySection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
