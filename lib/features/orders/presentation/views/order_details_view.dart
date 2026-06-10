import 'package:flouka_pos/core/constants/app_lotties.dart';
import 'package:flouka_pos/core/widgets/loading_animation_widget.dart';
import 'package:flouka_pos/core/widgets/price_details_widget.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/features/orders/domain/entity/order_entity.dart';
import 'package:flouka_pos/features/orders/presentation/widgets/delivery_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_styles.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../chat/presentation/pages/message_page.dart';
import '../../../chat/presentation/provider/message_provider.dart';
import '../providers/order_details_provider.dart';
import '../widgets/delivery_item_widget.dart';
import '../widgets/item_summary_section.dart';
import '../widgets/order_card_widget.dart';
import '../widgets/order_details_header.dart';
import '../widgets/update_order_widget.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    final messageProvider = Provider.of<MessageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fd),
      appBar: AppBar(
      ),
      body: Builder(
        builder: (context) {
          if (orderDetailsProvider.orderEntity == null) {
            return const Center(child: LoadingAnimationWidget(gif: Lotties.loading));
          }
          return Column(
            children: [
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
              Expanded(
                child: Row(
                  children: [
                    Expanded(flex: 2,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


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
                                        Expanded(
                                          child: OrderCardWidget(
                                            withButton: false,
                                            orderEntity: orderDetailsProvider.orderEntity!,
                                          ),
                                        ),
                                        const Expanded(child: DeliveryAddressWidget()),
                                        if(!messageProvider.isShowChat)
                                        const Expanded(child: PriceDetailesList()),

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  if(messageProvider.isShowChat)...[
                                    const PriceDetailesList(),
                                    SizedBox(height: 4.h),
                                  ],

                                  const ItemSummarySection(),
                                ],
                              ),
                            ),
                            SizedBox(height: 4.h),
                          ],
                        ),
                      ),
                    ),
                    if(messageProvider.isShowChat)
                      const Expanded(child: MessagePage()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
