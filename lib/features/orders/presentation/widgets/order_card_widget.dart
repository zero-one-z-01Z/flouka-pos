import 'package:flouka_pos/core/constants/app_images.dart';
import 'package:flouka_pos/core/helper_function/convert.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/core/widgets/svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_color.dart';
import '../../domain/entity/order_entity.dart';
import '../providers/order_details_provider.dart';

class OrderCardWidget extends StatelessWidget {
  final OrderEntity orderEntity;
  final bool withButton;
  const OrderCardWidget({super.key, required this.orderEntity, required this.withButton});

  @override
  Widget build(BuildContext context) {
    final OrderDetailsProvider orderDetailsProvider = Provider.of<OrderDetailsProvider>(context);
    return InkWell(
      onTap: () {
        if(withButton){
          orderDetailsProvider.goToOrderDetailsView(orderEntity.id);
        }

      },
      child: Container(
        color: Colors.white,
        width: 23.w,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Details
            _buildDetailRow(
              LanguageProvider.translate('global', 'Order ID'),
              orderEntity.id.toString(),
            ),
            _buildDetailRow(
              LanguageProvider.translate('global', 'customer_name'),
              orderEntity.user?.name ?? '',
            ),
            _buildDetailRow(
              LanguageProvider.translate('global', 'total_price'),
              orderEntity.total.toString(),
            ),
            _buildDetailRow(
              LanguageProvider.translate('global', 'payment_method'),
              orderEntity.paymentMethod,
            ),
            _buildDetailRow(
              LanguageProvider.translate('global', 'order_time'),
              convertDateTimeToStringDMY(DateTime.parse(orderEntity.createdAt)),
            ),
            // _buildDetailRow(
            //   LanguageProvider.translate('global', 'items_count'),
            //   orderEntity.vendorOrders?.length.toString()??'0',
            // ),
            _buildDetailRow(
              LanguageProvider.translate('global', 'Address'),
              orderEntity.address.address,
            ),

            // Order Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 2,
                  child: Text("${LanguageProvider.translate('global', 'order_status')} :",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 1.w),
                Expanded(flex: 3,
                  child: Text(
                    LanguageProvider.translate('global', orderEntity.vendorOrders.status.text),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: orderEntity.status.color,
                    ),
                  ),
                ),
              ],
            ),
            // if (withButton)...[
            //   // const Divider(color: Colors.grey, thickness: 0.5),
            //   SizedBox(height: 2.h),
            //   ButtonWidget(
            //     height: 4.h,
            //     borderRadius: 8,
            //     onTap: () {
            //
            //     },
            //     text: LanguageProvider.translate('global', 'more_details'),
            //     textStyle: TextStyle(
            //       fontSize: 10.sp,
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   SizedBox(height: 2.h),
            // ],

          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                "${label} : ",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 1.w),
            Expanded(
              flex: 3,
              child: Text(
                " ${LanguageProvider.translate('global', value)}",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const Divider(color: Colors.grey, thickness: 0.5),
      ],
    );
  }
}
