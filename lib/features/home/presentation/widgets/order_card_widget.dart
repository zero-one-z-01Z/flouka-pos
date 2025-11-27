import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
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
          SizedBox(height: 2.h),

          // Action Buttons
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w600),
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        // SizedBox(height: .h),
        const Divider(color: Colors.grey, thickness: 0.5),
      ],
    );
  }
}
