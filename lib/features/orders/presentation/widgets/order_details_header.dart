import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_color.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../domain/entity/order_entity.dart';
import '../providers/order_details_provider.dart';

class OrderDetailsHeader extends StatelessWidget {
  const OrderDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    print('xxxxxxxxxxxxxxxxxxx ${orderDetailsProvider.buttonMap()}');
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LanguageProvider.translate('global', 'order_details'),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${LanguageProvider.translate('global', 'order_id_label')} : ${orderDetailsProvider.orderEntity?.id}",
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          if(orderDetailsProvider.canUpdateStock())...[
            Expanded(
              child: ButtonWidget(
                color: const Color(0xffa90003),
                borderRadius: 8,
                height: 6.h,
                onTap: () {
                  orderDetailsProvider.rejectOrderDialog();
                },
                text: "cancel_order",
              ),
            ),
            SizedBox(width: 1.5.w),
            Expanded(flex: 2,
              child: ButtonWidget(
                color: AppColor.primaryColor,
                borderRadius: 8,
                height: 6.h,
                onTap: () {
                  orderDetailsProvider.updateOrderStock();
                },
                text: "accept_order",
              ),
            ),
          ],

          if(orderDetailsProvider.buttonMap().isNotEmpty)...[
            Expanded(flex: 2,
              child: ButtonWidget(
                color: Colors.green,
                borderRadius: 8,
                height: 6.h,
                onTap: () {
                  orderDetailsProvider.buttonMap()['onTap']();
                },
                text:orderDetailsProvider.buttonMap()['title'] ,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
