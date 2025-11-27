import 'package:flouka_pos/core/widgets/price_details_widget.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/orders/presentation/widgets/delivery_address_widget.dart';
import 'package:flouka_pos/features/orders/presentation/widgets/order_details_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_styles.dart';
import '../widgets/order_card_widget.dart';
import '../widgets/order_details_header.dart';

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

                  Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LanguageProvider.translate("global", "Item Summary"),
                          style: TextStyleClass.smallStyle().copyWith(),
                        ),
                        SizedBox(height: 2.h),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: List.generate(
                            6,
                            (index) => const OrderDetailsItemWidget(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
