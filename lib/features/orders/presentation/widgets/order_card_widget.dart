import 'package:flouka_pos/core/constants/app_images.dart';
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
  const OrderCardWidget({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    final OrderDetailsProvider orderDetailsProvider =
        Provider.of<OrderDetailsProvider>(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: SingleChildScrollView(
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
                  orderEntity.userName,
                ),
                _buildDetailRow(
                  LanguageProvider.translate('global', 'total_price'),
                  orderEntity.total,
                ),
                _buildDetailRow(
                  LanguageProvider.translate('global', 'payment_method'),
                  orderEntity.paymentMethod,
                ),
                _buildDetailRow(
                  LanguageProvider.translate('global', 'order_time'),
                  orderEntity.orderTime,
                ),
                _buildDetailRow(
                  LanguageProvider.translate('global', 'items_count'),
                  orderEntity.itemCount.toString(),
                ),
                _buildDetailRow(
                  LanguageProvider.translate('global', 'Address'),
                  orderEntity.address,
                ),

                // Order Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        LanguageProvider.translate('global', 'order_status'),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      LanguageProvider.translate('global', 'processing'),
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.grey, thickness: 0.5),
                SizedBox(height: 0.5.h),
                ButtonWidget(
                  height: 4.h,
                  borderRadius: 8,
                  onTap: () {},
                  text: LanguageProvider.translate('global', 'more_details'),
                  textStyle: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: -10,
          top: -10,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primaryColor,
            ),
            child: const SvgWidget(svg: Images.notification, width: 20, height: 20),
          ),
        ),
      ],
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
                label,
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 1.w),
            Expanded(
              flex: 3,
              child: Text(
                ": $value",
                style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
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
