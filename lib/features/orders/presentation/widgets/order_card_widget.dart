import 'package:flouka_pos/core/constants/app_images.dart';
import 'package:flouka_pos/features/language/presentation/provider/language_provider.dart';
import 'package:flouka_pos/core/widgets/button_widget.dart';
import 'package:flouka_pos/core/widgets/svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_color.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Details
              _buildDetailRow(
                LanguageProvider.translate('global', 'Order ID'),
                "56456",
              ),
              _buildDetailRow(
                LanguageProvider.translate('global', 'customer_name'),
                "3omran",
              ),
              _buildDetailRow(
                LanguageProvider.translate('global', 'total_price'),
                "1000",
              ),
              _buildDetailRow(
                LanguageProvider.translate('global', 'payment_method'),
                "Visa",
              ),
              _buildDetailRow(
                LanguageProvider.translate('global', 'order_time'),
                "09/10/2025 - 10:30 AM",
              ),
              _buildDetailRow(
                LanguageProvider.translate('global', 'items_count'),
                "10",
              ),
              _buildDetailRow(
                LanguageProvider.translate('global', 'Address'),
                "Smoha,32 ElBulring,20Alex...",
              ),

              // Order Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LanguageProvider.translate('global', 'order_status'),
                    style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
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
              SizedBox(height: 1.h),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 2.w),
            Text(
              ": " + value,
              style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w600),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        const Divider(color: Colors.grey, thickness: 0.5),
      ],
    );
  }
}
