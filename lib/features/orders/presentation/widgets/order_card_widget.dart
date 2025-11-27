import 'package:flouka_pos/core/constants/app_images.dart';
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
              _buildDetailRow('Order ID', "56456"),
              _buildDetailRow('Customer Name', "3omran"),
              _buildDetailRow('Total Price', "1000"),
              _buildDetailRow('Payment Method', "Visa"),
              _buildDetailRow('Order Time', "09/10/2025 - 10:30 AM"),
              _buildDetailRow('Items Count', "10"),
              _buildDetailRow('Address', "Smoha,32 ElBulring,20Alex..."),

              // Order Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Status',
                    style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Processing",
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
                text: "More Detils",
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
